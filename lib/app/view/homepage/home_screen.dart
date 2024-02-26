import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ljubljana/app/models/distance_model.dart';
import 'package:ljubljana/app/state/authentication_store/authentication_store.dart';
import 'package:ljubljana/app/state/user_profile_store/user_profile_store.dart';
import 'package:ljubljana/routing/routes.dart';
import 'package:ljubljana/theme/color_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../common_widgets/common_loader.dart';
import '../../locator.dart';
import '../../utils/storage_prefs_manager.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthenticationStore authStore = locator<AuthenticationStore>();
  final UserProfileStore profileStore = locator<UserProfileStore>();

  late TooltipBehavior _tooltipBehavior;
  String? email;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FOSLoaderCircleWhite(context: context);
      _getInitialData().then((value) {
        Navigator.of(context).pop();
      });
    });
    super.initState();
  }

  Future<void> _getInitialData() async {
    email = await storagePrefs.readEmailFromShared();
    await authStore.fetchDBUser().then((value) => authStore.getUserInitials());
    await profileStore.getPhoto();
    await profileStore.fetchDBDistance(email!);
    await profileStore.fetchDBTopDistance(email!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
      child: Scaffold(
          appBar: AppBar(backgroundColor: ColorHelper.blue.color, elevation: 0, leading: const SizedBox()),
          body: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              _buildWhiteCoverContainer(context),
              _buildBlueCoverContainer(context),
              _buildHeadline(context),
              Positioned(bottom: 110, child: _buildChart(context)),
              Positioned(bottom: 0, left: MediaQuery.of(context).size.width / 3, child: _buildStartButton(context)),
            ],
          ),
          const SizedBox(height: 20),
          _buildTopResultSection(context),
        ],
      ),
    );
  }

  Widget _buildBlueCoverContainer(BuildContext context) {
    return Container(
        height: 400,
        decoration: BoxDecoration(
            color: ColorHelper.blue.color,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))));
  }

  Widget _buildWhiteCoverContainer(BuildContext context) {
    return Container(
      height: 460,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('home.hi'.tr(),
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.white.color)),
              Observer(
                builder: (BuildContext context) {
                  return Text(authStore.user.firstName,
                      style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.white.color));
                },
              ),
            ],
          ),
          _profileIcon(context),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context) {
    List<_ChartData> data = profileStore.distances.reversed.map((DistanceModel e) {
      return _ChartData(e.createdDate, e.distance.toDouble());
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 1.06,
            height: 217,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: ColorHelper.white.color!),
                    bottom: BorderSide(color: ColorHelper.white.color!))),
            child: SfCartesianChart(
                onActualRangeChanged: (value) => print(value),
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: const CategoryAxis(isVisible: false, maximum: 9),
                backgroundColor: Colors.transparent,
                plotAreaBackgroundColor: Colors.transparent,
                plotAreaBorderColor: Colors.transparent,
                series: <CartesianSeries<_ChartData, String>>[
                  LineSeries<_ChartData, String>(
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      name: 'History data',
                      color: Colors.white,
                      enableTooltip: true,
                      dataLabelSettings: const DataLabelSettings(isVisible: true))
                ]),
          ),
          const SizedBox(height: 10),
          Text('home.history_data'.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: ColorHelper.white.color, fontWeight: FontWeight.w300))
        ],
      ),
    );
  }

  Widget _profileIcon(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(settingsScreen).then((value) => _getInitialData()),
          child: profileStore.userPhoto == null
              ? Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(color: ColorHelper.blue.color, shape: BoxShape.circle),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColorHelper.white.color!.withOpacity(0.35),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Center(
                        child: Text('${authStore.userFInitials}${authStore.userLInitials}',
                            style: Theme.of(context).textTheme.headline6)),
                  ),
                )
              : Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(227, 233, 239, 1),
                    borderRadius: BorderRadius.circular(128.0),
                  ),
                  child: ClipOval(
                    child: Container(
                      height: 60,
                      width: 60,
                      child: Image.network(profileStore.userPhoto!, fit: BoxFit.cover),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(agreementScreen),
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(color: ColorHelper.red.color, shape: BoxShape.circle),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorHelper.white.color!.withOpacity(0.35),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Center(
            child: Text(
              'home.start_test'.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 20, color: ColorHelper.white.color),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopResultSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('home.top_3_res'.tr(),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w900)),
          _buildTopResults(context),
        ],
      ),
    );
  }

  Widget _buildTopResults(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profileStore.topDistances.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: _resultCard(context, index, profileStore.topDistances[index].distance));
      },
    );
  }

  Widget _resultCard(BuildContext context, int index, int distance) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: index == 0 ? ColorHelper.lightBlue.color : ColorHelper.lightGrey.color,
        border: Border.all(color: index == 0 ? ColorHelper.blue.color! : ColorHelper.darkGrey.color!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${index + 1}',
                style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Text('home.distance'.tr(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
              )
            ],
          ),
          Text(
            '$distance${'home.meter'.tr()}',
            style: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: ColorHelper.darkGrey.color),
          )
        ],
      ),
    );
  }
}

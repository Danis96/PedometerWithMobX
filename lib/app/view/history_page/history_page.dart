import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/theme/color_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
      child: Scaffold(appBar: AppBar(backgroundColor: ColorHelper.blue.color, elevation: 0, leading: const SizedBox()), body: _buildBody(context)),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return ListView(
    shrinkWrap: true,
    children: <Widget>[
      Stack(
        children: <Widget>[
          _buildWhiteCoverContainer(context),
          _buildBlueCoverContainer(context),
          _buildHeadline(context),
          Positioned(bottom: 110, child: _buildChart(context)),
        ],
      ),
      _buildTopResultSection(context),
    ],
  );
}

Widget _buildBlueCoverContainer(BuildContext context) {
  return Container(
      height: 400,
      decoration: BoxDecoration(
          color: ColorHelper.blue.color, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))));
}

Widget _buildWhiteCoverContainer(BuildContext context) {
  return Container(
    height: 460,
    decoration: const BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
  );
}

Widget _buildHeadline(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios, size: 40, color: ColorHelper.white.color)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text('history.your_history'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.white.color)),
            Text('history.data'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.white.color)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildChart(BuildContext context) {
  List<_ChartData> data = [
    _ChartData('CHN', 10),
    _ChartData('GER', 15),
    _ChartData('RUS', 30),
    _ChartData('BRZ', 6.4),
    _ChartData('IND', 14),
    _ChartData('BRsZ', 6.4),
    _ChartData('IsND', 14),
    _ChartData('BRdZ', 6.4),
    _ChartData('INaD', 14),
  ];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1.06,
          height: 217,
          decoration:
          BoxDecoration(border: Border(left: BorderSide(color: ColorHelper.white.color!), bottom: BorderSide(color: ColorHelper.white.color!))),
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(isVisible: false, maximum: 9),
              backgroundColor: Colors.transparent,
              plotAreaBackgroundColor: Colors.transparent,
              plotAreaBorderColor: Colors.transparent,
              primaryYAxis: CategoryAxis(isVisible: false),
              series: <ChartSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'History data',
                  color: Colors.white,
                  isTrackVisible: false,
                )
              ]),
        ),
        const SizedBox(height: 10),
        Text('history.history_data'.tr(),
            style: Theme.of(context).textTheme.headline6!.copyWith(color: ColorHelper.white.color, fontWeight: FontWeight.w300))
      ],
    ),
  );
}



Widget _buildTopResultSection(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('history.results'.tr(), style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w900)),
        _buildTopResults(context),
      ],
    ),
  );
}

Widget _buildTopResults(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _results.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(padding: const EdgeInsets.symmetric(vertical: 5), child: _resultCard(context, index, _results[index]));
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('21.03.2022'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                ),
                Text('home.distance'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            )
          ],
        ),
        Text(
          '$distance${'home.meter'.tr()}',
          style: Theme.of(context).textTheme.caption!.copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: ColorHelper.darkGrey.color),
        )
      ],
    ),
  );
}

List<int> _results = [555, 512, 422, 443, 666];

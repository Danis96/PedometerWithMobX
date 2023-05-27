import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../theme/color_helper.dart';

class WalkingSuccessPage extends StatelessWidget {
  const WalkingSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomCurrentDistance(context)));
  }
}

Widget _buildBody(BuildContext context) => SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));

Widget _buildHeadline(BuildContext context) {
  return ListView(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    children: <Widget>[
      const SizedBox(height: 50),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('agreement_success.you_did'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.blue.color)),
          Text('agreement_success.great_job'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
        ],
      ),
      const SizedBox(height: 20),
      _buildImage(context),
    ],
  );
}

Widget _buildImage(BuildContext context) {
  return Center(child: Image.asset('assets/ic_success.png'));
}

Widget _buildBottomCurrentDistance(BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      alignment: Alignment.bottomCenter,
      height: 150,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'agreement_success.total_distance'.tr(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.w300),
              children: <TextSpan>[TextSpan(text: '450m', style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color))])));
}

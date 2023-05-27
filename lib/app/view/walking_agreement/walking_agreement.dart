import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/walking_distance_store/walking_distance_store.dart';
import 'package:ljubljana/common_widgets/common_two_buttons.dart';

import '../../../common_widgets/common_button.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';

class WalkingAgreementPage extends StatelessWidget {
  WalkingAgreementPage({Key? key}) : super(key: key);

  final WalkingDistanceStore store = locator<WalkingDistanceStore>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(height: double.infinity, child: ListView(shrinkWrap: true, children: [_buildHeadline(context)]));
  }

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
            Text('agreement.lets_try'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.blue.color)),
            Text('agreement.test'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
          ],
        ),
        const SizedBox(height: 10),
        _buildHeadlineText(context),
        const SizedBox(height: 20),
        _buildConfirmCheckbox(context),
      ],
    );
  }

  Widget _buildHeadlineText(BuildContext context) {
    return Text('agreement.main_text'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w300, fontSize: 18));
  }

  Widget _buildConfirmCheckbox(BuildContext context) {
    return Row(
      children: <Widget>[
        Observer(
          builder: (BuildContext context) {
            return Checkbox(value: store.confirmTest, onChanged: (bool? value) => store.setConfirmTest(value!));
          },
        ),
        Text('agreement.confirm_check'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      alignment: Alignment.bottomCenter,
      height: 150,
      child: FOSTwoButtons(
        leftBtnFunction: () => Navigator.of(context).pop(),
        rightBtnFunction: () => Navigator.of(context).pushNamed(walkingTypeScreen),
        rightBtnType: BtnType.blue,
        leftBtnTextColor: ColorHelper.red.color!,
        leftBtnText: 'agreement.btn_cancel'.tr(),
        rightBtnText: 'agreement.btn_start'.tr(),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/common_two_buttons.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';
import '../../utils/modal_helper.dart';

class WalkingTypePage extends StatefulWidget {
  const WalkingTypePage({Key? key}) : super(key: key);

  @override
  State<WalkingTypePage> createState() => _WalkingTypePageState();
}

class _WalkingTypePageState extends State<WalkingTypePage> {
  bool indoor = false;
  bool free = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          body: _buildBody(context),
          bottomNavigationBar: _buildBottomButton(context),
        ));
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: ListView(
        shrinkWrap: true,
        children: [
          _buildHeadline(context),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: <Widget>[
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('walking_type.title'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
          ],
        ),
        const SizedBox(height: 30),
        Text('walking_type.test_2_title'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('walking_type.test_2_desc'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorHelper.black.color,)),
        const SizedBox(height: 10),
        _buildConfirmCheckboxFreewill(context),
        const SizedBox(height: 30),
        Text('walking_type.test_1_title'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('walking_type.test_1_desc'.tr(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorHelper.black.color,)),
        const SizedBox(height: 10),
        _buildConfirmCheckboxIndoor(context),
      ],
    );
  }

  Widget _buildConfirmCheckboxIndoor(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(value: indoor, onChanged: (bool? value) {
          setState(() {
            indoor = value!;
            if (value) {
              free = false;
            }
          });
        }),
        Text('walking_type.confirm_indoor_and_supervision'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget _buildConfirmCheckboxFreewill(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(value: free, onChanged: (bool? value) {
          setState(() {
            free = value!;
            if (value) {
              indoor = false;
            }
          });
        }),
        Text('walking_type.confirm_free_will'.tr(), style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w400)),
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
        rightBtnFunction: () {
          ModalHelper().returnErrorModalOrFn(context, (!indoor && !free) ? 'Please choose one test' : null, function: () => Navigator.of(context).pushNamed(indoor ? walkingStepsRoute : agreementTestScreen));
        },
        rightBtnType: BtnType.blue,
        leftBtnTextColor: ColorHelper.red.color!,
        leftBtnText: 'agreement.btn_cancel'.tr(),
        rightBtnText: 'agreement.btn_start'.tr(),
      ),
    );
  }
}

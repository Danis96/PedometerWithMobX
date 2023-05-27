import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/locator.dart';
import 'package:ljubljana/app/state/pedometer_store/pedometer_store.dart';

import '../../../../common_widgets/common_button.dart';
import '../../../../common_widgets/common_text_field.dart';
import '../../../../common_widgets/common_two_buttons.dart';
import '../../../../routing/routes.dart';
import '../../../../theme/color_helper.dart';

class WalkingPedometerPage extends StatefulWidget {
  const WalkingPedometerPage({Key? key}) : super(key: key);

  @override
  State<WalkingPedometerPage> createState() => _WalkingPedometerPageState();
}

class _WalkingPedometerPageState extends State<WalkingPedometerPage> {
  final PedometerStore store = locator<PedometerStore>();

  final TextEditingController distanceController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

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
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('walking_type.title'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.blue.color)),
          ],
        ),
        const SizedBox(height: 30),
        Text('walking_type.test_1_title'.tr(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Text('walking_type.test_1_desc'.tr(),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorHelper.black.color,
                )),
        const SizedBox(height: 50),
        _buildDistanceStepsPlaceholders(context),
        const SizedBox(
          height: 10,
        ),
        _buildDistanceStepsFields(context),
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your step length is: ${calculateStepLength()}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
          ],
        ),
      ],
    );
  }

  Widget _buildDistanceStepsPlaceholders(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Flexible(
            child: Text('Distance in metres', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
          ),
          Flexible(
            child: Text(
              'Steps in metres',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceStepsFields(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Flexible(
            child: FOSTextFormField(
              onChange: (String? input) {
                setState(() {
                  store.measuredDistanceForSteps = double.parse(distanceController.text);
                });
              },
              keyboardType: TextInputType.number,
              hintText: 'Distance'.tr(),
              controller: distanceController,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: FOSTextFormField(
              keyboardType: TextInputType.number,
              onChange: (String? input) {
                setState(() {
                  store.measuredStepLength = double.parse(stepsController.text);
                });
              },
              hintText: 'Steps'.tr(),
              controller: stepsController,
            ),
          ),
        ],
      ),
    );
  }

  String calculateStepLength() {
    if (distanceController.text.isEmpty || stepsController.text.isEmpty) {
      return '-';
    } else {
      int distance = int.tryParse(distanceController.text)!;
      int steps = int.tryParse(stepsController.text)!;
      if (distance != null && steps != null) {
        return (distance / steps).toStringAsFixed(3) + 'm';
      }

      return '-';
    }
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      alignment: Alignment.bottomCenter,
      height: 150,
      child: FOSTwoButtons(
        leftBtnFunction: () => Navigator.of(context).pop(),
        rightBtnFunction: () {
          Navigator.of(context).pushNamed(walkingPedometerTestRoute, arguments: store);
        },
        rightBtnType: BtnType.blue,
        leftBtnTextColor: ColorHelper.red.color!,
        leftBtnText: 'agreement.btn_cancel'.tr(),
        rightBtnText: 'agreement.btn_start'.tr(),
      ),
    );
  }
}

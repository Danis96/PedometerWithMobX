import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ljubljana/app/state/onboarding_store/onboarding_store.dart';

import '../../../common_widgets/common_button.dart';
import '../../../routing/routes.dart';
import '../../../theme/color_helper.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage(this.onBoardingStore, {Key? key}) : super(key: key);

  final OnBoardingStore onBoardingStore;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/grey_background.png'), fit: BoxFit.cover)),
        child: Scaffold(body: _buildBody(context), bottomNavigationBar: _buildBottomButton(context)));
  }

  Widget _buildBody(BuildContext context) {
    return SizedBox(height: double.infinity, child: _buildHeadline(context));
  }

  Widget _buildHeadline(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Image.asset('assets/ic_questions.png', height: MediaQuery.of(context).size.height / 2.3),
          const SizedBox(height: 20),
          _buildHeadlineText(context),
        ],
      ),
    );
  }

  Widget _buildHeadlineText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('question.answer'.tr(), style: Theme.of(context).textTheme.bodyText1!.copyWith(color: ColorHelper.darkGrey.color)),
        Text('question.questions'.tr(), style: Theme.of(context).textTheme.caption!.copyWith(color: ColorHelper.darkGrey.color)),
        const SizedBox(height: 5),
        Text(
          'question.proceed_text'.tr(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorHelper.black.color, fontWeight: FontWeight.w200),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      height: 100,
      child: FOSButton(
        onPressed: () => Navigator.of(context).pushNamed(questionsViewPager, arguments: onBoardingStore),
        btnType: BtnType.grey,
        buttonTitle: 'question.btn_questions'.tr(),
      ),
    );
  }
}



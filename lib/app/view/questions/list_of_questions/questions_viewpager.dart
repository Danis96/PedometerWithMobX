import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ljubljana/app/models/question_model.dart';
import 'package:ljubljana/app/state/questions_store/questions_store.dart';
import 'package:ljubljana/theme/color_helper.dart';

import '../../../../common_widgets/common_loader.dart';
import '../../../../common_widgets/common_two_buttons.dart';
import '../../../../routing/routes.dart';
import '../../../locator.dart';
import '../../../state/onboarding_store/onboarding_store.dart';

class QuestionsViewPager extends StatefulWidget {
  const QuestionsViewPager(this.onBoardingStore, {Key? key}) : super(key: key);

  final OnBoardingStore onBoardingStore;

  @override
  State<QuestionsViewPager> createState() => _QuestionsViewPagerState();
}

class _QuestionsViewPagerState extends State<QuestionsViewPager> {
  final QuestionsStore store = locator<QuestionsStore>();

  @override
  void dispose() {
    locator.unregister<QuestionsStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Text('questions.title'.tr(), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w400, fontSize: 18)),
              Observer(
                builder: (BuildContext context) {
                  return Text(
                    '${store.currentPage + 1} of ${store.questions.length}',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600, fontSize: 28),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildBackground(),
          PageView(
            pageSnapping: true,
            controller: store.pageController,
            onPageChanged: (int index) {
              store.currentPage = index;
            },
            children: listOfPages(store.questions),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FOSTwoButtons(
          leftBtnText: 'questions.answer_no'.tr(),
          rightBtnText: 'questions.answer_yes'.tr(),
          leftBtnFunction: () => setAnswerForQuestion(context, false).then((value) => changePage(false)),
          rightBtnFunction: () => setAnswerForQuestion(context, true).then((value) => changePage(true)),
        ),
      ),
    );
  }

  Future<void> setAnswerForQuestion(BuildContext context, bool value) async {
    store.setAnswerID(store.questionIndex);
    store.setAnswerValue(value);
    await store.answerQuestion();
  }

  Widget _buildBackground() =>
      Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/green_background.png'), fit: BoxFit.cover)));

  List<Widget> listOfPages(List<Question> pages) {
    final List<Widget> result = pages.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Text(
            e.description,
            style: TextStyle(color: ColorHelper.black.color, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
    return result;
  }

  void changePage(bool isConfirmed) async {
    store.questionIndex++;
    if ((store.currentPage + 1) < store.questions.length) {
      store.pageController.animateToPage(++store.currentPage, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      store.questions[store.currentPage].isConfirmed = isConfirmed;
      fOSLoaderCircleWhite(context: context);
      Future.delayed(const Duration(milliseconds: 1000), () async {
        await widget.onBoardingStore.onBoarding().then((String? error) {
          Navigator.of(context).pop();
          print('Success onboarding');
          Navigator.of(context).pushNamed(homeScreen);
        });
      });
    }
  }
}

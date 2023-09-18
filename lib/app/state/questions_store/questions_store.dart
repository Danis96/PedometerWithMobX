import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../models/question_model.dart';
import '../../repositories/questions_repository.dart';
import '../../utils/storage_prefs_manager.dart';

part 'questions_store.g.dart';

class QuestionsStore = QuestionBase with _$QuestionsStore;

abstract class QuestionBase with Store {
  QuestionBase() {
    _questionsRepository = QuestionsRepository();
  }

  QuestionsRepository? _questionsRepository;

  bool answer = false;
  int answerID = 0;

  @observable
  PageController pageController = PageController(initialPage: 0);
  @observable
  int currentPage = 0;
  @observable
  int questionIndex = 1;


  @observable
  List<Question> questions = <Question>[
    Question(description: 'questions.question_desc_1'.tr()),
    Question(description: 'questions.question_desc_2'.tr()),
    Question(description: 'questions.question_desc_3'.tr()),
    Question(description: 'questions.question_desc_4'.tr()),
    Question(description: 'questions.question_desc_5'.tr()),
    Question(description: 'questions.question_desc_6'.tr()),
    Question(description: 'questions.question_desc_7'.tr()),
  ];



  Future<String?> answerQuestion() async {
    try {
      final String email = await storagePrefs.readEmailFromShared();
      await _questionsRepository!.answerQuestion(email, answerID, answer);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @action
  void setAnswerValue(bool value) {
    answer = value;
  }

  @action
  void setAnswerID(int value) {
    answerID = value;
  }
}

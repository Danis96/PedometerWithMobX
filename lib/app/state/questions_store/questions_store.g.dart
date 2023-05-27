// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuestionsStore on QuestionBase, Store {
  late final _$pageControllerAtom =
      Atom(name: 'QuestionBase.pageController', context: context);

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  late final _$currentPageAtom =
      Atom(name: 'QuestionBase.currentPage', context: context);

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  late final _$questionIndexAtom =
      Atom(name: 'QuestionBase.questionIndex', context: context);

  @override
  int get questionIndex {
    _$questionIndexAtom.reportRead();
    return super.questionIndex;
  }

  @override
  set questionIndex(int value) {
    _$questionIndexAtom.reportWrite(value, super.questionIndex, () {
      super.questionIndex = value;
    });
  }

  late final _$questionsAtom =
      Atom(name: 'QuestionBase.questions', context: context);

  @override
  List<Question> get questions {
    _$questionsAtom.reportRead();
    return super.questions;
  }

  @override
  set questions(List<Question> value) {
    _$questionsAtom.reportWrite(value, super.questions, () {
      super.questions = value;
    });
  }

  late final _$QuestionBaseActionController =
      ActionController(name: 'QuestionBase', context: context);

  @override
  void setAnswerValue(bool value) {
    final _$actionInfo = _$QuestionBaseActionController.startAction(
        name: 'QuestionBase.setAnswerValue');
    try {
      return super.setAnswerValue(value);
    } finally {
      _$QuestionBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAnswerID(int value) {
    final _$actionInfo = _$QuestionBaseActionController.startAction(
        name: 'QuestionBase.setAnswerID');
    try {
      return super.setAnswerID(value);
    } finally {
      _$QuestionBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageController: ${pageController},
currentPage: ${currentPage},
questionIndex: ${questionIndex},
questions: ${questions}
    ''';
  }
}

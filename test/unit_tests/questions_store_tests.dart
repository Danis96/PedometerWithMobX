import 'package:flutter_test/flutter_test.dart';
import 'package:ljubljana/app/state/questions_store/questions_store.dart';
import 'package:ljubljana/network_module/api_header.dart';
import 'package:ljubljana/network_module/api_path.dart';
import 'package:nock/nock.dart';

import '../test_helper.dart';

void main() {
  late QuestionsStore questionsStore;
  bool setupCalled = false;

  setUpAll(() {
    nock.init();
    nock.defaultBase = testBaseUrl;
  });

  setUp(() async {
    nock.cleanAll();
    if (!setupCalled) {
      setupLocatorForTests();
    }
    questionsStore = locatorTest<QuestionsStore>();
    setupCalled = true;
  });

  group('check initial values of variables', () {
    test('initial bool value for [answer] should be false', () {
      expect(questionsStore.answer, false);
    });
    test('initial int value for [answerID] should be 0', () {
      expect(questionsStore.answerID, 0);
    });
    test('initial int value for [currentPage] should be 0', () {
      expect(questionsStore.currentPage, 0);
    });
    test('initial int value for [questionIndex] should be 1', () {
      expect(questionsStore.questionIndex, 1);
    });
    test('initial list value for list [questions] should be 7 length', () {
      expect(questionsStore.questions.length, questionsTest.length);
    });
  });

  group('test setters [setAnswerValue] & [setAnswerID]', () {
    test('setAnswerID should change answerID variable to 666', () {
      questionsStore.setAnswerID(666);
      expect(questionsStore.answerID, 666);
    });
    test('setAnswerValue should change answer variable to true', () {
      questionsStore.setAnswerValue(false);
      expect(questionsStore.answer, false);
    });
  });

  test('answerQuestion, calling api, nock used for mocking data and api call', () async {
    final dynamic object = <String, dynamic>{'Email': 'test@test.com', 'AnswerId': 666, 'Answer':false};
    final dynamic response = <String, String>{'success': 'success'};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final interceptor = nock.post(ApiPathHelper.getValue(ApiPath.answerQuestions), object)..reply(200, response, headers: header);
    expect(interceptor.isDone, false);
    expect(interceptor.body, response);
    expect(interceptor.statusCode, 200);
  });
}

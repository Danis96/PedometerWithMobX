import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class QuestionsRepository {

  Future<void> answerQuestion(String email, int answerID, bool answer) async {
    final dynamic object = <String, dynamic>{'Email': email, 'AnswerId': answerID, 'Answer': answer};
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.answerQuestions), header, body: object);
  }

}


import 'package:ljubljana/app/models/distance_model.dart';

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class DistanceRepository {

  Future<List<DistanceModel>> getUserDistances(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.getDistances, concatValue: email), header);
    print(response);
    List<DistanceModel> listOfDistances;
    final List<dynamic> responseJson = response['success']['userDistance'] as List<dynamic>;

    listOfDistances = responseJson.map((dynamic value) => DistanceModel.fromJson(value)).toList();
    return listOfDistances;
  }

  Future<List<DistanceModel>> getUserTopDistances(String email) async {
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.getTopDistances, concatValue: email), header);
    print(response);
    List<DistanceModel> listOfDistances;
    final List<dynamic> responseJson = response['success']['userDistance'] as List<dynamic>;

    listOfDistances = responseJson.map((dynamic value) => DistanceModel.fromJson(value)).toList();
    return listOfDistances;
  }

  Future<void> setUserDistance(
      String email, int distance,) async {
    final dynamic object = <String, dynamic>{
      'Email': email,
      'Distance': distance,
    };
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.setDistance), header, body: object);
  }
}
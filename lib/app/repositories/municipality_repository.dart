import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class MunicipalityRepository {
  Future<List<String>> getMunicipalities() async {
    List<String> listOfMunicipalities;
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.authAppJson);
    final dynamic response = await HTTPClient.instance.fetchData(ApiPathHelper.getValue(ApiPath.get_municipalities), header);
    final List<dynamic> responseJson = response['success']['municipalities'] as List<dynamic>;
    listOfMunicipalities = responseJson.map((e) => e.toString()).toList();
    return listOfMunicipalities;
  }
}

import '../../network_module/api_header.dart';
import '../../network_module/api_path.dart';
import '../../network_module/http_client.dart';

class OnBoardingRepository {
  Future<void> createUserDetails(
      String fName, String lName, String email, int gender, int age, int height, int weight, String info,String municipality, bool onBoardingFinished) async {
    final dynamic object = <String, dynamic>{
      'FirstName': fName,
      'LastName': lName,
      'Email': email,
      'Gender': gender,
      'Age': age,
      'Height': height,
      'Weight': weight,
      'Info': info,
      'Municipality': municipality,
      'IsOnboardingFinished': onBoardingFinished
    };
    final Map<String, String> header = await ApiHeaderHelper.getValue(ApiHeader.appJson);
    final dynamic response = await HTTPClient.instance.postData(ApiPathHelper.getValue(ApiPath.createUserDetails), header, body: object);
  }
}

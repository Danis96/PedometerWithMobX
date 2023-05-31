import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../app/config/flavor_config.dart';
import 'api_exceptions.dart';

class HTTPClient {
  static final HTTPClient _singleton = HTTPClient();

  static HTTPClient get instance => _singleton;

  Future<dynamic> fetchData(String url, Map<String, String> headersType, {Map<String, dynamic>? params}) async {
    dynamic responseJson;

    final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
    debugPrint(uri);
    try {
      final http.Response response = await http.get(Uri.parse(uri), headers: headersType);
      debugPrint(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> deleteData(String url, Map<String, String> headersType, {Map<String, String>? params, Map<String, dynamic>? body}) async {
    dynamic responseJson;
    final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
    try {
      final http.Response response = await http.delete(Uri.parse(uri), headers: headersType, body: body != null ? jsonEncode(body) : null);
      debugPrint(response.body.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  Future<dynamic> postData(String url, Map<String, String> headerType, {dynamic body}) async {
    dynamic responseJson;
    try {
      debugPrint('Json body ${jsonEncode(body)}');
      final http.Response response =
          await http.post(Uri.parse(FlavorConfig.instance.values.baseUrl + url), body: body != null ? jsonEncode(body) : null, headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> patchData(String url, dynamic body, Map<String, String> headerType) async {
    dynamic responseJson;
    try {
      final http.Response response =
          await http.patch(Uri.parse(FlavorConfig.instance.values.baseUrl + url), body: jsonEncode(body), headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> putData(String url, dynamic body, Map<String, String> headerType, {bool isAws = false}) async {
    dynamic responseJson;
    try {
      debugPrint(body.toString());
      final http.Response response =
          await http.put(Uri.parse(isAws ? '' : FlavorConfig.instance.values.baseUrl + url), body: jsonEncode(body), headers: headerType);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body) async {
    dynamic responseJson;
    try {
      debugPrint(body.toString());
      final http.Response response = await http.put(Uri.parse(url), body: body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartData(String url, Map<String, String> body, Map<String, String> headerType, File file) async {
    debugPrint(body.toString());
    dynamic responseJson;
    try {
      final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(FlavorConfig.instance.values.baseUrl + url));
      request.files.add(http.MultipartFile.fromBytes('Images', file.readAsBytesSync(), filename: 'Photo.jpg'));
      request.fields.addAll(body);
      request.headers.addAll(headerType);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> getMultipartData(String url, Map<String, String> body, Map<String, String> headerType) async {
    debugPrint(body.toString());
    dynamic responseJson;
    try {
      final http.MultipartRequest request = http.MultipartRequest('GET', Uri.parse(FlavorConfig.instance.values.baseUrl + url))
        ..headers.addAll(headerType)
        ..fields.addAll(body);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> postMultipartImage(String url, Map<String, String> headerType, String imageFile) async {
    debugPrint(imageFile);
    dynamic responseJson;
    try {
      final http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(FlavorConfig.instance.values.baseUrl + url))
        ..files.add(await http.MultipartFile.fromPath('image', imageFile));
      request.headers.addAll(headerType);
      final http.StreamedResponse response = await request.send();
      final http.Response parserResponse = await http.Response.fromStream(response);
      responseJson = _returnResponse(parserResponse);
      debugPrint(responseJson);
    } on SocketException {
      throw InternetException('No internet connection');
    } on Exception catch (_) {
      rethrow;
    }
    return responseJson;
  }

  String queryParameters(Map<String, dynamic> params) {
    if (params != null) {
      final Uri jsonString = Uri(queryParameters: params);
      return '?${jsonString.query}';
    }
    return '';
  }

  dynamic _returnResponse(http.Response response) async {
    debugPrint(response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
      case 204:
        try {
          final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
          return responseJson ?? '';
        } catch (e) {
          return;
        }
      case 201:
        final dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
      case 401:
      case 404:
      case 405:
        final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestValidationException.fromJson(responseJson);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
        throw BadRequestValidationException.fromJson(responseJson);
      default:
        throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}

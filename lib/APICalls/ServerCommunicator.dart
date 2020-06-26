import 'package:boilerplate/Constants/Config.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:io';

import 'package:package_info/package_info.dart';

class APIProvider {
  Dio getDio() {
    Dio dio = new Dio();
//    /*DISABLE_PROXY_START true
//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//        (HttpClient client) {
//      client.findProxy = (uri) {
//        return "PROXY 192.168.11.78:8888";
//      };
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => true;
//    };
// DISABLE_PROXY_END true*/
    return dio;
  }

  Future<Map<String, dynamic>> doLogin(String mobile,String scope) async {

    var mobilejson = {"mobile": mobile};
    var mobileWithScopeJson = {"mobile": mobile, "role": scope};

    Response response = await getDio().post(Config.loginUrl,
        data: scope == "" ? mobilejson : mobileWithScopeJson
        );
//    final userResponse = LoginResponse.fromJson(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> doLoginWithEmail(String email, String password) async {
    Response response = await getDio().post(Config.signupUrl,
        data: {"type": 3, "username": email, "password": password});
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOTP(String otpHash, int otp) async {
    Response response = await getDio().post(Config.otpUrl, data: {
      "otp": otp,
      "id": otpHash,
      "deviceType": "Mobile",
      "fcmToken": "",
      "deviceInfo": [{
        "deviceId": "",
        "phoneModel": "",
        "operatingSystem": "",
        "applicationClient": "",
        "applicationVersion": ""
      }]
    });
    return response.data;
  }

  Future<Map<String, dynamic>> checkAppVersions() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    var buildString = '';
    if (Platform.isAndroid) {
      buildString = buildNumber.toString();
    } else {
      buildString = version.replaceAll('.', '') +
          (buildNumber.length == 1 ? ("0" + buildNumber) : buildNumber);
    }

    Response response = await getDio().get(Config.appVersion,
        options: Options(
          headers: {
            'appVersion': buildString,
            'deviceType': Platform.isAndroid ? 1 : 2 // 1 = android , 2 = iOS
          },
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> uploadSingleImage(File filePath, String uploadImageUrl, String uploadImageKey) async {

    FormData formData = new FormData.fromMap({
      uploadImageKey: await MultipartFile.fromFile(
          filePath.path, filename: filePath.path),
    });

    var response = await getDio().post(uploadImageUrl,
        data: formData,
        options: Options(method: 'POST', responseType: ResponseType.json));
    return response.data;
  }

  Future<Map<String, dynamic>> uploadMultipleImages(List<MultipartFile> images, String uploadImageUrl, String uploadImageKey) async {

    FormData formData = new FormData.fromMap({
      uploadImageKey: images,
    });

     var response = await getDio().post(uploadImageUrl, data: formData, options: Options(
         method: 'POST',
         responseType: ResponseType.json
     ));
     return response.data;
  }
}
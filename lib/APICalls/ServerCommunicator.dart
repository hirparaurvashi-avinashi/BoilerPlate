import 'package:dio/dio.dart';
import 'dart:io';

import 'package:package_info/package_info.dart';

class APIProvider {
  Dio getDio() {
    Dio dio = new Dio();
    /*DISABLE_PROXY_START true
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY 192.168.11.78:8888";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
// DISABLE_PROXY_END true*/
    return dio;
  }

  Future<Map<String, dynamic>> doLogin(String mobile,String loginApiUrl) async {
    Response response = await getDio().post(loginApiUrl,
        data: {"mobile": mobile});
//    final userResponse = LoginResponse.fromJson(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOTP(String otpHash, int otp,String otpOrl) async {
    Response response = await getDio().post(otpOrl, data: {
      "otp": otp,
      "mobileToken": otpHash,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> checkAppVersions(String checkAppVersionUrl) async {
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

    Response response = await getDio().get(checkAppVersionUrl,
        options: Options(
          headers: {
            'appVersion': buildString,
            'deviceType': Platform.isAndroid ? 1 : 2 // 1 = android , 2 = iOS
          },
        ));
    return response.data;
  }

}
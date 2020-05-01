import 'package:boilerplate/Models/LoginModel.dart';
import 'package:dio/dio.dart';

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

  Future<LoginResponse> doLogin(String mobile,String loginApiUrl) async {
    Response response = await getDio().post(loginApiUrl,
        data: {"mobile": mobile});
    final userResponse = LoginResponse.fromJson(response.data);
    return userResponse;
  }

}
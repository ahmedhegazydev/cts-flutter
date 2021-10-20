import 'package:http/http.dart';

class Http {
  Future<Response> getRequest(String url) async {
    return await get(
      Uri.parse(url),
    );
  }

  Future<Response> postRequest(String url, String params) async {
    return await post(Uri.parse(url), body: params);
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class Http {
  Future<http.Response> get(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    String responseContent = response.body;
    if (response.statusCode == 200) {
      return jsonDecode(responseContent);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<http.Response> post(String url, String payload) async {
    final headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: payload,
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

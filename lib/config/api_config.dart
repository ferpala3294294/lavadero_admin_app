import 'package:http/http.dart' as http;

class APIConfig {
  static const String baseUrl = "http://127.0.0.1/lavadero_api";

  static Future<http.Response> get(String endpoint) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    return await http.get(url);
  }

  static Future<http.Response> post(
      String endpoint, Map<String, String> body) async {
    final url = Uri.parse("$baseUrl/$endpoint");
    return await http.post(url, body: body);
  }
}

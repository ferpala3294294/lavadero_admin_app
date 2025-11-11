import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class PatentesService {
  static Future<List<Map<String, dynamic>>> getPatentes() async {
    final url = Uri.parse("${APIConfig.baseUrl}/patentes_get.php");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return List<Map<String, dynamic>>.from(data);
    }
    return [];
  }

  static Future<bool> agregarPatente(String patente) async {
    final url = Uri.parse("${APIConfig.baseUrl}/patentes_add.php");
    final res = await http.post(url, body: {"patente": patente});
    return res.statusCode == 200;
  }

  static Future<bool> eliminarPatente(int id) async {
    final url = Uri.parse("${APIConfig.baseUrl}/patentes_delete.php");
    final res = await http.post(url, body: {"id": id.toString()});
    return res.statusCode == 200;
  }

  static Future<bool> eliminarTodas() async {
    final url = Uri.parse("${APIConfig.baseUrl}/patentes_delete_all.php");
    final res = await http.get(url);
    return res.statusCode == 200;
  }

  static Future<bool> actualizarPatente(int id, String patente) async {
    final url = Uri.parse("${APIConfig.baseUrl}/patentes_update.php");
    final res = await http.post(
      url,
      body: {"id": id.toString(), "patente": patente},
    );
    return res.statusCode == 200;
  }
}

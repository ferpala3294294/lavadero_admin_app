import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class PromocionesService {
  // 🔹 Obtener todas las promociones
  static Future<List<Map<String, dynamic>>> getPromociones() async {
    final url = Uri.parse("${APIConfig.baseUrl}/promociones_get.php");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      if (body["success"] == true) {
        return List<Map<String, dynamic>>.from(body["data"]);
      }
    }
    return [];
  }

  // 🔹 Agregar promoción
  static Future<bool> agregarPromocion(
      String nombre, String descripcion, int dias) async {
    final url = Uri.parse("${APIConfig.baseUrl}/promociones_add.php");
    final res = await http.post(url, body: {
      "nombre": nombre,
      "descripcion": descripcion,
      "dias": dias.toString(),
    });
    return res.statusCode == 200;
  }

  // 🔹 Actualizar promoción
  static Future<bool> actualizarPromocion(
      int id, String nombre, String descripcion) async {
    final url = Uri.parse("${APIConfig.baseUrl}/promociones_update.php");
    final res = await http.post(url, body: {
      "id": id.toString(),
      "nombre": nombre,
      "descripcion": descripcion,
    });
    return res.statusCode == 200;
  }

  // 🔹 Eliminar una promoción
  static Future<bool> eliminarPromocion(int id) async {
    final url = Uri.parse("${APIConfig.baseUrl}/promociones_delete.php");
    final res = await http.post(url, body: {"id": id.toString()});
    return res.statusCode == 200;
  }

  // 🔹 Eliminar todas las promociones
  static Future<bool> eliminarTodas() async {
    final url = Uri.parse("${APIConfig.baseUrl}/promociones_delete_all.php");
    final res = await http.get(url);
    return res.statusCode == 200;
  }
}

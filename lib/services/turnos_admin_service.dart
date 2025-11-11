import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class TurnosAdminService {
  /// ✅ OBTENER TODOS LOS TURNOS
  static Future<List<Map<String, dynamic>>> getTurnos() async {
    final resp = await APIConfig.get("turnos_admin_listar.php");
    final body = jsonDecode(resp.body);

    if (body["status"] == "success") {
      return List<Map<String, dynamic>>.from(body["data"]);
    }
    return [];
  }

  /// ✅ AGREGAR TURNO MANUAL
  static Future<bool> agregarTurno({
    required int idUsuario,
    required int idServicio,
    required String fecha,
    required String hora,
    required String tipoVehiculo,
  }) async {
    final resp = await APIConfig.post("turnos_admin_agregar.php", {
      "id_usuario": idUsuario.toString(),
      "id_servicio": idServicio.toString(),
      "fecha": fecha,
      "hora": hora,
      "tipo_vehiculo": tipoVehiculo,
      "metodo_carga": "manual",
    });

    final body = jsonDecode(resp.body);
    return body["status"] == "success";
  }

  /// ✅ CANCELAR TURNO
  static Future<bool> cancelarTurno(int idTurno) async {
    final resp = await APIConfig.post("turnos_admin_cancelar.php", {
      "id": idTurno.toString(),
    });

    final body = jsonDecode(resp.body);
    return body["status"] == "success";
  }
}

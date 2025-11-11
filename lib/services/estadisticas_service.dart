import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class EstadisticasMensualesService {
  static Future<List<int>> obtenerMensuales() async {
    try {
      final res = await APIConfig.get("get_estadisticas_mensuales.php");
      final body = jsonDecode(res.body);

      if (body["status"] == "success") {
        final data = body["data"];
        return List<int>.generate(12, (i) {
          final mes = (i + 1).toString();
          return data[mes] ?? 0;
        });
      }
    } catch (e) {
      print("ERROR obtenerMensuales: $e");
    }

    return List<int>.filled(12, 0);
  }
}

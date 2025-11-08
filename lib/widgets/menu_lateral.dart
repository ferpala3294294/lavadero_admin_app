import 'package:flutter/material.dart';

// Importaciones correctas a tus pantallas:
import '../screens/pantalla_estadisticas.dart';
import '../screens/pantalla_patentes.dart';
import '../screens/pantalla_promociones.dart';
import '../screens/pantalla_turnos.dart';
import '../screens/pantalla_precios.dart';

class MenuLateral extends StatelessWidget {
  final String seleccionado; // estadisticas, patentes, promociones, turnos, precios
  MenuLateral({super.key, required this.seleccionado});

  Widget item(BuildContext context, String nombre, String id, Widget pantalla) {
    final activo = (seleccionado == id);
    return ListTile(
      title: Text(
        nombre,
        style: TextStyle(
          color: activo ? Colors.white : Colors.white70,
          fontWeight: activo ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: activo ? Colors.blueGrey[700] : Colors.transparent,
      onTap: () {
        if (!activo) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => pantalla),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.blueGrey[900],
      child: Column(
        children: [
          const SizedBox(height: 30),
          item(context, "Estadísticas", "estadisticas", PantallaEstadisticas()),
          item(context, "Patentes", "patentes", PantallaPatentes()),
          item(context, "Promociones", "promociones", PantallaPromociones()),
          item(context, "Turnos", "turnos", PantallaTurnos()),
          item(context, "Precios", "precios", PantallaPrecios()),
        ],
      ),
    );
  }
}

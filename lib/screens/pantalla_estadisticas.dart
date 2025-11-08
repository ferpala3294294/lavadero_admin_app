import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../turnos_data.dart';
import 'pantalla_estadisticas_mensuales.dart';
import '../widgets/menu_lateral.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ✅ Obtener datos
    final turnos = turnosGlobal;

    int autos = turnos.where((t) => t["vehiculo"] == "Auto").length;
    int camionetas = turnos.where((t) => t["vehiculo"] == "Camioneta").length;
    int motos = turnos.where((t) => t["vehiculo"] == "Moto").length;
    int bicis = turnos.where((t) => t["vehiculo"] == "Bici").length;

    autos = autos == 0 ? 1 : autos;
    camionetas = camionetas == 0 ? 1 : camionetas;
    motos = motos == 0 ? 1 : motos;
    bicis = bicis == 0 ? 1 : bicis;

    final total = autos + camionetas + motos + bicis;

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),

      body: Row(
        children: [
          // ✅ MENÚ LATERAL CORRECTO
          MenuLateral(seleccionado: "estadisticas"),

          // ✅ CONTENIDO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: const [
                      Icon(Icons.analytics,
                          color: Color(0xFF00BFFF), size: 30),
                      SizedBox(width: 10),
                      Text(
                        "Resumen del Mes",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BFFF),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: SizedBox(
                      height: 260,
                      width: 260,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 45,
                          sectionsSpace: 2,
                          sections: [
                            PieChartSectionData(
                              color: Colors.blue,
                              value: autos.toDouble(),
                              title: '${((autos / total) * 100).round()}%',
                              radius: 85,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              color: Colors.green,
                              value: camionetas.toDouble(),
                              title: '${((camionetas / total) * 100).round()}%',
                              radius: 85,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              color: Colors.purple,
                              value: motos.toDouble(),
                              title: '${((motos / total) * 100).round()}%',
                              radius: 85,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            PieChartSectionData(
                              color: Colors.amber,
                              value: bicis.toDouble(),
                              title: '${((bicis / total) * 100).round()}%',
                              radius: 85,
                              titleStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        LegendItem(color: Colors.blue, text: "Autos"),
                        SizedBox(width: 20),
                        LegendItem(color: Colors.green, text: "Camionetas"),
                        SizedBox(width: 20),
                        LegendItem(color: Colors.purple, text: "Motos"),
                        SizedBox(width: 20),
                        LegendItem(color: Colors.amber, text: "Bicis"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const PantallaEstadisticasMensuales(),
                        ),
                      ),
                      child: const Text(
                        "Mes",
                        style: TextStyle(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({
    required this.color,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

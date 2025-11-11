import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../turnos_data.dart';
import '../widgets/menu_lateral.dart';

class PantallaEstadisticasMensuales extends StatelessWidget {
  const PantallaEstadisticasMensuales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mesesCorto = const [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];

    final conteoPorMes = List<int>.filled(12, 0);

    for (final t in turnosGlobal) {
      DateTime? fecha;
      final raw = t['fecha'];

      if (raw is DateTime) {
        fecha = raw;
      } else if (raw is String) {
        try {
          fecha = DateTime.parse(raw);
        } catch (_) {
          try {
            final p = raw.split('/');
            if (p.length == 3) {
              fecha = DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
            }
          } catch (_) {}
        }
      }

      if (fecha != null) {
        conteoPorMes[fecha.month - 1]++;
      }
    }

    final maxValor = conteoPorMes.reduce((a, b) => a > b ? a : b);
    final yMax = (maxValor == 0) ? 10.0 : (maxValor * 1.4);

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          MenuLateral(seleccionado: "estadisticas"),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.bar_chart, color: Color(0xFF00BFFF), size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Estadísticas Mensuales',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BFFF),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: yMax,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                final i = value.toInt();
                                if (i < 0 || i > 11) {
                                  return const SizedBox.shrink();
                                }
                                return Text(
                                  mesesCorto[i],
                                  style: const TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                        barGroups: List.generate(12, (i) {
                          final v = conteoPorMes[i].toDouble();
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: v,
                                width: 14,
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF00BFFF),
                        side: const BorderSide(color: Color(0xFF00BFFF)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Volver"),
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

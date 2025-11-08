import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ✅ Traemos los turnos reales
import '../turnos_data.dart';

// ✅ Import del menú lateral CORRECTO
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

          // ✅ MENÚ LATERAL OFICIAL
          MenuLateral(seleccionado: "estadisticas"),

          // ✅ CONTENIDO PRINCIPAL
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ✅ CORRECCIÓN: sacar el const del Row
                  Row(
                    children: const [
                      Icon(Icons.bar_chart, color: Color(0xFF00BFFF), size: 30),
                      SizedBox(width: 10),
                      Text(
                        'Resumen del Mes',
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

                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.black87,
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final mes = mesesCorto[group.x.toInt()];
                              final valor = rod.toY.toInt();
                              return BarTooltipItem(
                                '$mes\n$valor lavados',
                                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                        ),

                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                final i = value.toInt();
                                if (i < 0 || i > 11) return const SizedBox.shrink();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    mesesCorto[i],
                                    style: const TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),

                        gridData: FlGridData(
                          show: true,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.white12,
                            strokeWidth: 1,
                          ),
                        ),

                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.transparent),
                            bottom: BorderSide(color: Colors.white24),
                          ),
                        ),

                        barGroups: List.generate(12, (i) {
                          final v = conteoPorMes[i].toDouble();
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: v,
                                width: 16,
                                borderRadius: BorderRadius.circular(4),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1397E8),
                                    Color(0xFF43C6F9),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
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
                        foregroundColor: const Color(0xFF43C6F9),
                        side: const BorderSide(color: Color(0xFF43C6F9)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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

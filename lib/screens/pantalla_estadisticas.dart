import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'pantalla_patentes.dart';
import 'pantalla_promociones.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> trabajadores = const [
    {"nombre": "Juan Pérez", "diasTrabajados": 20},
    {"nombre": "María López", "diasTrabajados": 18},
    {"nombre": "Carlos Gómez", "diasTrabajados": 22},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const autos = 90;
    const camionetas = 30;
    const total = autos + camionetas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Row(
        children: [
          // 📊 Menú lateral
          Container(
            width: 220,
            color: Colors.blueGrey[900],
            child: Column(
              children: [
                ListTile(
                  title: const Text('Estadísticas', style: TextStyle(color: Colors.white)),
                  tileColor: Colors.blueGrey[700],
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Patentes', style: TextStyle(color: Colors.white70)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PantallaPatentes()),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Promociones', style: TextStyle(color: Colors.white70)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PantallaPromociones()),
                    );
                  },
                ),
              ],
            ),
          ),

          // 📈 Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resumen de Lavados',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Gráfico circular
                  Center(
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 40,
                          sectionsSpace: 2,
                          sections: [
                            PieChartSectionData(
                              color: Colors.lightBlueAccent,
                              value: autos.toDouble(),
                              title: '${((autos / total) * 100).round()}%',
                              radius: 80,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.orangeAccent,
                              value: camionetas.toDouble(),
                              title: '${((camionetas / total) * 100).round()}%',
                              radius: 80,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 📅 Lista de empleados
                  Text(
                    'Días trabajados por empleado',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Expanded(
                    child: ListView.separated(
                      itemCount: trabajadores.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final t = trabajadores[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t['nombre'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              Text(
                                '${t['diasTrabajados']} días',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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

import 'package:flutter/material.dart';
import 'pantalla_estadisticas.dart';
import 'pantalla_patentes.dart';

class PantallaPromociones extends StatelessWidget {
  const PantallaPromociones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final promociones = [
      {
        'titulo': '🎉 15% de descuento',
        'descripcion': 'Aplica a clientes frecuentes con más de 5 lavados al mes.',
        'color1': Colors.blueAccent,
        'color2': Colors.lightBlueAccent,
      },
      {
        'titulo': '🚗 Promo 2x1',
        'descripcion': 'Vení el fin de semana y lavá 2 vehículos por el precio de 1.',
        'color1': Colors.deepPurpleAccent,
        'color2': Colors.purpleAccent,
      },
      {
        'titulo': '💦 Lavado Express Gratis',
        'descripcion': 'Con cualquier lavado completo de lunes a miércoles.',
        'color1': Colors.teal,
        'color2': Colors.cyan,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Promociones')),
      body: Row(
        children: [
          // Menú lateral
          Container(
            width: 220,
            color: theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Estadísticas'),
                  textColor: Colors.grey,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PantallaEstadisticas()));
                  },
                ),
                ListTile(
                  title: const Text('Patentes'),
                  textColor: Colors.grey,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PantallaPatentes()));
                  },
                ),
                ListTile(
                  title: const Text('Promociones'),
                  textColor: Colors.white,
                  tileColor: Colors.blueGrey.shade800,
                  onTap: () {},
                ),
              ],
            ),
          ),
          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '🎯 Promociones Especiales',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: promociones.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        final promo = promociones[index];
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [promo['color1'] as Color, promo['color2'] as Color],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                promo['titulo'] as String,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                promo['descripcion'] as String,
                                style: const TextStyle(color: Colors.white70),
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

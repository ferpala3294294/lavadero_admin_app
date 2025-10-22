import 'package:flutter/material.dart';
import 'pantalla_estadisticas.dart';
import 'pantalla_promociones.dart';

class PantallaPatentes extends StatelessWidget {
  const PantallaPatentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Patente')),
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
                  textColor: Colors.white,
                  tileColor: Colors.blueGrey.shade800,
                  onTap: () {},
                ),
                ListTile(
                  title: const Text('Promociones'),
                  textColor: Colors.grey,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const PantallaPromociones()));
                  },
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
                    'Ingresar Patente',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.cardColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: 'Patente',
                            hintText: 'Ej: ABC123 / XYZ-987',
                            prefixIcon: const Icon(Icons.directions_car),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final patente = controller.text.trim();
                              if (patente.isNotEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Patente "$patente" registrada.')),
                                );
                                controller.clear();
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
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

import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import 'patentes_listado.dart'; // ✅ Import del listado

class PantallaPatentes extends StatelessWidget {
  const PantallaPatentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [

          /// ✅ MENÚ LATERAL
          MenuLateral(seleccionado: "patentes"),

          /// ✅ CONTENIDO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text(
                    "Ingresar Patente",
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// ✅ Caja contenedora
                  Container(
                    width: 450,
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xFF152238),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [

                        /// ✅ Campo Patente
                        TextField(
                          controller: controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Patente",
                            labelStyle: const TextStyle(color: Colors.white70),
                            prefixIcon: const Icon(Icons.directions_car, color: Colors.white70),
                            filled: true,
                            fillColor: const Color(0xFF1D2A3A),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white24),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ✅ Botón Guardar
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              final patente = controller.text.trim();
                              if (patente.isEmpty) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("✅ Patente $patente guardada"),
                                ),
                              );

                              controller.clear();
                            },
                            icon: const Icon(Icons.lock_outline, size: 18),
                            label: const Text(
                              "Guardar",
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0094FF),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// ✅ Botón VER (te lleva al listado)
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PatentesListado(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white24),
                              backgroundColor: const Color(0xFF2A3B4F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Ver",
                              style: TextStyle(color: Colors.white, fontSize: 16),
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

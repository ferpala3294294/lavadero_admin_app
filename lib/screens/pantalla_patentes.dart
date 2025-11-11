import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../services/patentes_service.dart';

class PantallaPatentes extends StatefulWidget {
  const PantallaPatentes({Key? key}) : super(key: key);

  @override
  State<PantallaPatentes> createState() => _PantallaPatentesState();
}

class _PantallaPatentesState extends State<PantallaPatentes> {
  final TextEditingController patenteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          MenuLateral(seleccionado: "patentes"),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Row(
                    children: [
                      Icon(Icons.directions_car,
                          color: Color(0xFF00BFFF), size: 32),
                      SizedBox(width: 12),
                      Text(
                        "Cargar Patentes",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BFFF),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  TextField(
                    controller: patenteController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Ingrese patente...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF112233),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFFF),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 14),
                      ),
                      onPressed: guardarPatente,
                      child: const Text(
                        "Guardar Patente",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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

  /// ✅ MÉTODO FINAL PARA GUARDAR LA PATENTE
  void guardarPatente() async {
    String patente = patenteController.text.trim();

    if (patente.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Ingrese una patente")),
      );
      return;
    }

    /// ✅ Guardar en la BD
    final ok = await PatentesService.agregarPatente(patente);

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Patente $patente guardada")),
      );

      patenteController.clear(); // ✅ Limpia el input

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Error al guardar")),
      );
    }
  }
}

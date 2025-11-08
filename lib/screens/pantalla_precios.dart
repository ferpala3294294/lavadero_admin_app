import 'package:flutter/material.dart';
import '../widgets/../widgets/menu_lateral.dart';

class PantallaPrecios extends StatefulWidget {
  const PantallaPrecios({Key? key}) : super(key: key);

  @override
  State<PantallaPrecios> createState() => _PantallaPreciosState();
}

class _PantallaPreciosState extends State<PantallaPrecios> {
  final TextEditingController exteriorCtrl = TextEditingController(text: "2500");
  final TextEditingController interiorCtrl = TextEditingController(text: "3000");
  final TextEditingController expressCtrl = TextEditingController(text: "2000");
  final TextEditingController mensualCtrl = TextEditingController(text: "10000");

  void guardarPrecios() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Precios guardados correctamente"),
      ),
    );
  }

  Widget precioField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        const SizedBox(height: 6),

        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            prefixText: "\$ ",
            prefixStyle: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),

      body: Row(
        children: [
          /// ✅ MENÚ LATERAL UNIFICADO (NO DESAPARECE MÁS)
          MenuLateral(seleccionado: "precios"),

          /// ✅ CONTENIDO PRINCIPAL
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Cargar Precios",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Seleccioná los precios del servicio",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),

                  precioField("Lavado Exterior", exteriorCtrl),
                  precioField("Lavado Interior", interiorCtrl),
                  precioField("Lavado Exprés", expressCtrl),
                  precioField("Plan Mensual", mensualCtrl),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: guardarPrecios,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xFF005BBB),
                      ),
                      child: const Text("Guardar Precios"),
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

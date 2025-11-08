import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';

class PantallaPromociones extends StatefulWidget {
  const PantallaPromociones({Key? key}) : super(key: key);

  @override
  State<PantallaPromociones> createState() => _PantallaPromocionesState();
}

class _PantallaPromocionesState extends State<PantallaPromociones> {
  List<Map<String, dynamic>> promos = [
    {"titulo": "🎉 15% de descuento", "desc": "Clientes frecuentes"},
    {"titulo": "🎁 Promo 2x1", "desc": "Fin de semana"},
    {"titulo": "💦 Lavado Express Gratis", "desc": "Lun–Mié"},
  ];

  final tituloCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final diasCtrl = TextEditingController(text: "7");

  // ✅ ICONOS AUTOMÁTICOS
  String getIconForTitle(String title) {
    final t = title.toLowerCase();

    if (t.contains("lavado")) return "🚗";
    if (t.contains("promo") || t.contains("2x1")) return "🎁";
    if (t.contains("descuento") || t.contains("%")) return "💸";
    if (t.contains("gratis")) return "💦";
    if (t.contains("express") || t.contains("exprés")) return "⚡";

    return "⭐"; // default
  }

  // ✅ POPUP DE EDICIÓN
  void _editarPromo(int index) {
    final promo = promos[index];

    tituloCtrl.text = promo["titulo"].replaceAll(RegExp(r"^\S+ "), ""); // saca el icono
    descCtrl.text = promo["desc"];

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF112233),
          title: const Text("Editar Promoción",
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: tituloCtrl,
                decoration: const InputDecoration(
                  labelText: "Título",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(
                  labelText: "Descripción",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Cancelar", style: TextStyle(color: Colors.red))),
            TextButton(
              onPressed: () {
                final icono = getIconForTitle(tituloCtrl.text);

                setState(() {
                  promos[index] = {
                    "titulo": "$icono ${tituloCtrl.text}",
                    "desc": descCtrl.text,
                  };
                });

                Navigator.pop(ctx);
              },
              child: const Text("Guardar",
                  style: TextStyle(color: Colors.lightBlue)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          MenuLateral(seleccionado: "promociones"),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🎯 Promociones Especiales",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),

                  // ✅ input + guardar
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: tituloCtrl,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Título",
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),

                      SizedBox(
                        width: 80,
                        child: TextField(
                          controller: diasCtrl,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            labelText: "Días",
                            labelStyle: TextStyle(color: Colors.white70),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          final icono = getIconForTitle(tituloCtrl.text);

                          setState(() {
                            promos.add({
                              "titulo": "$icono ${tituloCtrl.text}",
                              "desc":
                                  "${descCtrl.text} (${diasCtrl.text} días)",
                            });
                          });

                          tituloCtrl.clear();
                          descCtrl.clear();
                          diasCtrl.text = "7";
                        },
                        child: const Text("Guardar"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: descCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Descripción",
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ LISTADO DE PROMOS
                  Expanded(
                    child: ListView.builder(
                      itemCount: promos.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(.15),
                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ✅ información
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(promos[i]["titulo"],
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text(promos[i]["desc"],
                                        style: const TextStyle(
                                            color: Colors.white70)),
                                  ],
                                ),
                              ),

                              // ✅ MENÚ DE 3 PUNTITOS
                              PopupMenuButton(
                                color: const Color(0xFF112233),
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white70),
                                itemBuilder: (_) => [
                                  // ✅ EDITAR
                                  PopupMenuItem(
                                    value: "editar",
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit,
                                            color: Colors.white70, size: 20),
                                        SizedBox(width: 8),
                                        Text("Editar",
                                            style: TextStyle(
                                                color: Colors.white)),
                                      ],
                                    ),
                                  ),

                                  // ✅ ELIMINAR
                                  PopupMenuItem(
                                    value: "eliminar",
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete,
                                            color: Colors.redAccent, size: 20),
                                        SizedBox(width: 8),
                                        Text("Eliminar",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == "editar") {
                                    _editarPromo(i);
                                  } else if (value == "eliminar") {
                                    setState(() {
                                      promos.removeAt(i);
                                    });
                                  }
                                },
                              )
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

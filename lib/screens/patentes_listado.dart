import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../services/patentes_service.dart';

class PatentesListado extends StatefulWidget {
  const PatentesListado({super.key});

  @override
  State<PatentesListado> createState() => _PatentesListadoState();
}

class _PatentesListadoState extends State<PatentesListado> {
  late Future<List<Map<String, dynamic>>> patentesFuture;

  @override
  void initState() {
    super.initState();
    _refrescar();
  }

  void _refrescar() {
    setState(() {
      patentesFuture = PatentesService.getPatentes();
    });
  }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Patentes",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      PopupMenuButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        color: const Color(0xFF1D2A3A),
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: "eliminar_todo",
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever, color: Colors.red),
                                SizedBox(width: 10),
                                Text("Eliminar TODO", style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                        onSelected: (value) async {
                          if (value == "eliminar_todo") {
                            final ok = await PatentesService.eliminarTodas();
                            if (ok) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("✅ Todas las patentes eliminadas")),
                              );
                              _refrescar();
                            }
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Expanded(
                    child: FutureBuilder(
                      future: patentesFuture,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(color: Colors.white),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "No hay patentes registradas",
                              style: TextStyle(color: Colors.white70, fontSize: 18),
                            ),
                          );
                        }

                        final patentes = snapshot.data!;

                        return ListView.builder(
                          itemCount: patentes.length,
                          itemBuilder: (_, i) {
                            final p = patentes[i];
                            final id = p["id"];
                            final patente = p["patente"];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1D2A3A),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.directions_car, color: Colors.white70),
                                      const SizedBox(width: 12),
                                      Text(
                                        patente,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),

                                  PopupMenuButton(
                                    color: const Color(0xFF1D2A3A),
                                    icon: const Icon(Icons.more_vert, color: Colors.white70),
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: "editar",
                                        child: Row(
                                          children: [
                                            Icon(Icons.edit, color: Colors.white70, size: 20),
                                            SizedBox(width: 10),
                                            Text("Editar", style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem(
                                        value: "eliminar",
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete, color: Colors.redAccent, size: 20),
                                            SizedBox(width: 10),
                                            Text("Eliminar", style: TextStyle(color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) async {
                                      if (value == "eliminar") {
                                        final ok = await PatentesService.eliminarPatente(id);
                                        if (ok) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("🗑️ Eliminada $patente")),
                                          );
                                          _refrescar();
                                        }
                                      }

                                      if (value == "editar") {
                                        _editarPatente(context, id, patente);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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

  // ✅ Dialogo para editar patente
  void _editarPatente(BuildContext context, int id, String actual) {
    final controller = TextEditingController(text: actual);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF112233),
        title: const Text("Editar Patente", style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: "Patente",
            labelStyle: TextStyle(color: Colors.white70),
          ),
        ),
        actions: [
          TextButton(
            child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Guardar", style: TextStyle(color: Colors.lightBlue)),
            onPressed: () async {
              final nueva = controller.text.trim();
              if (nueva.isEmpty) return;

              final ok = await PatentesService.actualizarPatente(id, nueva);
              if (ok) {
                Navigator.pop(context);
                _refrescar();
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';

class PatentesListado extends StatelessWidget {
  const PatentesListado({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ Lista temporal (después conexión a BD)
    final List<String> patentes = [
      "ABC123",
      "AE458RT",
      "KDZ901",
      "BBQ210",
      "GGX889",
      "ASD441",
      "HJK102",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          /// ✅ Menú lateral
          MenuLateral(seleccionado: "patentes"),

          /// ✅ CONTENIDO
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ✅ FILA TITULO + BOTÓN ELIMINAR TODO
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

                      /// ✅ TACHITO DE ARRIBA A LA DERECHA
                      PopupMenuButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        color: const Color(0xFF1D2A3A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: "eliminar_todo",
                            child: Row(
                              children: const [
                                Icon(Icons.delete_forever,
                                    color: Colors.redAccent),
                                SizedBox(width: 10),
                                Text("Eliminar TODO",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          )
                        ],
                        onSelected: (value) {
                          if (value == "eliminar_todo") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "🗑️ Todas las patentes han sido eliminadas")),
                            );
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// ✅ LISTADO
                  Expanded(
                    child: ListView.builder(
                      itemCount: patentes.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D2A3A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// ✅ ICONO + TEXTO
                              Row(
                                children: [
                                  const Icon(Icons.directions_car,
                                      color: Colors.white70),
                                  const SizedBox(width: 12),
                                  Text(
                                    patentes[i],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              /// ✅ BOTÓN DE 3 PUNTOS (EDITAR/ELIMINAR)
                              PopupMenuButton(
                                icon: const Icon(Icons.more_vert,
                                    color: Colors.white70),
                                color: const Color(0xFF1D2A3A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onSelected: (value) {
                                  if (value == "editar") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "✏️ Editar ${patentes[i]}"),
                                      ),
                                    );
                                  } else if (value == "eliminar") {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "🗑️ Eliminada ${patentes[i]}"),
                                      ),
                                    );
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "editar",
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit,
                                            color: Colors.white70, size: 20),
                                        SizedBox(width: 10),
                                        Text("Editar",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: "eliminar",
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete,
                                            color: Colors.redAccent, size: 20),
                                        SizedBox(width: 10),
                                        Text("Eliminar",
                                            style: TextStyle(color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                ],
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

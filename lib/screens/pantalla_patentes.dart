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
  List<Map<String, dynamic>> patentes = [];
  bool cargando = false;

  @override
  void initState() {
    super.initState();
    _cargarPatentes();
  }

  Future<void> _cargarPatentes() async {
    setState(() => cargando = true);
    final data = await PatentesService.getPatentes();
    setState(() {
      patentes = data;
      cargando = false;
    });
  }

  Future<void> _guardarPatente() async {
    String patente = patenteController.text.trim();
    if (patente.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Ingrese una patente")),
      );
      return;
    }

    final ok = await PatentesService.agregarPatente(patente);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ Patente $patente guardada")),
      );
      patenteController.clear();
      _cargarPatentes();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Error al guardar patente")),
      );
    }
  }

  Future<void> _editarPatente(int id, String actual) async {
    final controller = TextEditingController(text: actual);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Editar patente"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: "Nueva patente"),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
          ElevatedButton(
            onPressed: () async {
              final nueva = controller.text.trim();
              if (nueva.isNotEmpty) {
                final ok = await PatentesService.actualizarPatente(id, nueva);
                Navigator.pop(context);
                if (ok) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("✅ Patente actualizada")),
                  );
                  _cargarPatentes();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("❌ Error al actualizar")),
                  );
                }
              }
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Future<void> _eliminarPatente(int id) async {
    final confirmar = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar patente"),
        content: const Text("¿Seguro que querés eliminar esta patente?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirmar == true) {
      final ok = await PatentesService.eliminarPatente(id);
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("🗑️ Patente eliminada")),
        );
        _cargarPatentes();
      }
    }
  }

  Future<void> _eliminarTodas() async {
    final confirmar = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Eliminar todas las patentes"),
        content: const Text("¿Seguro que querés eliminar TODAS las patentes?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar todo")),
        ],
      ),
    );

    if (confirmar == true) {
      final ok = await PatentesService.eliminarTodas();
      if (ok) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("🧹 Todas las patentes fueron eliminadas")),
        );
        _cargarPatentes();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          /// ✅ Menú lateral
          MenuLateral(seleccionado: "patentes"),

          /// ✅ CONTENIDO PRINCIPAL
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Título
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Gestión de Patentes",
                        style: TextStyle(
                          color: Color(0xFF00BFFF),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _eliminarTodas,
                        icon: const Icon(Icons.delete_forever, color: Colors.white),
                        label: const Text("Eliminar todo"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(height: 24),

                  // 🔹 Campo para agregar patente
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: patenteController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Ingrese nueva patente...",
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: const Color(0xFF112233),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _guardarPatente,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFFF),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text("Agregar"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 🔹 Tabla de patentes
                  cargando
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: patentes.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No hay patentes registradas",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: patentes.length,
                                  itemBuilder: (context, index) {
                                    final p = patentes[index];
                                    return Card(
                                      color: const Color(0xFF112233),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ListTile(
                                        title: Text(
                                          p["patente"] ?? '',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "Creado: ${p["creado_en"]}",
                                          style: const TextStyle(color: Colors.white54),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.amber),
                                              onPressed: () => _editarPatente(int.parse(p["id"].toString()), p["patente"]),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                                              onPressed: () => _eliminarPatente(int.parse(p["id"].toString())),
                                            ),
                                          ],
                                        ),
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

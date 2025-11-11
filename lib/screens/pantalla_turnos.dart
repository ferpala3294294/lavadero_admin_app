import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../services/turnos_admin_service.dart';
import 'package:intl/intl.dart';

class PantallaTurnos extends StatefulWidget {
  const PantallaTurnos({Key? key}) : super(key: key);

  @override
  State<PantallaTurnos> createState() => _PantallaTurnosState();
}

class _PantallaTurnosState extends State<PantallaTurnos> {
  late Future<List<Map<String, dynamic>>> turnosFuture;
  String filtroBusqueda = "";

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    setState(() {
      turnosFuture = TurnosAdminService.getTurnos();
    });
  }

  /// ✅ Función segura para convertir a int cualquier cosa
  int toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      body: Row(
        children: [
          MenuLateral(seleccionado: "turnos"),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TÍTULO
                  const Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: Color(0xFF00BFFF), size: 30),
                      SizedBox(width: 12),
                      Text("Turnos Reservados",
                          style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFF00BFFF),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🔍 BUSCADOR
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Buscar cliente...",
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: const Color(0xFF112233),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (v) {
                      setState(() => filtroBusqueda = v.toLowerCase());
                    },
                  ),

                  const SizedBox(height: 20),

                  /// LISTA DE TURNOS
                  Expanded(
                    child: FutureBuilder(
                      future: turnosFuture,
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(color: Colors.white));
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("No hay turnos registrados",
                                style: TextStyle(color: Colors.white70, fontSize: 18)),
                          );
                        }

                        /// ✅ Filtrado por nombre
                        final turnos = snapshot.data!
                            .where((t) => t["usuario_nombre"]
                                .toString()
                                .toLowerCase()
                                .contains(filtroBusqueda))
                            .toList();

                        return ListView.builder(
                          itemCount: turnos.length,
                          itemBuilder: (_, i) {
                            final t = turnos[i];

                            /// ✅ ID SEGUROS
                            final idTurno = toInt(t["id"]);

                            /// ✅ FECHA
                            final fechaTurno =
                                DateTime.parse("${t["fecha"]} ${t["hora"]}");
                            final esPasado = fechaTurno.isBefore(DateTime.now());

                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: esPasado
                                    ? const Color(0xFF331111)
                                    : const Color(0xFF112233),
                                borderRadius: BorderRadius.circular(14),
                              ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  /// INFO DEL TURNO
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cliente: ${t["usuario_nombre"]}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),

                                      Text("Servicio: ${t["servicio_nombre"]}",
                                          style: const TextStyle(color: Colors.white70)),
                                      Text("Fecha: ${t["fecha"]}",
                                          style: const TextStyle(color: Colors.white70)),
                                      Text("Hora: ${t["hora"]}",
                                          style: const TextStyle(color: Colors.white70)),
                                      Text("Vehículo: ${t["tipo_vehiculo"]}",
                                          style: const TextStyle(color: Colors.white70)),

                                      Text(
                                        "Método: ${t["metodo_carga"]}",
                                        style: TextStyle(
                                            color: t["metodo_carga"] == "manual"
                                                ? Colors.orange
                                                : Colors.lightGreenAccent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),

                                  /// MENÚ DE OPCIONES
                                  PopupMenuButton<String>(
                                    color: const Color(0xFF112233),
                                    onSelected: (value) async {
                                      if (value == "cancelar") {
                                        final ok =
                                            await TurnosAdminService.cancelarTurno(idTurno);

                                        if (ok) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                  content: Text("Turno cancelado ✅")));
                                          _refresh();
                                        }
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(
                                        value: "cancelar",
                                        child: Text("Cancelar turno",
                                            style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  /// BOTÓN AGREGAR
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFFF),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 14),
                      ),
                      onPressed: _abrirDialogoAgregarTurno,
                      child: const Text("Agregar Turno",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
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

  // -------------------------------
  // ✅ DIALOGO PARA AGREGAR TURNOS
  // -------------------------------
  void _abrirDialogoAgregarTurno() {
    String clienteID = "";
    String servicioID = "";
    String tipoVehiculo = "";
    String? hora;
    DateTime? fecha;

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF112233),
          title: const Text("Agregar Turno Manual",
              style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              children: [

                /// CLIENTE
                TextField(
                  decoration: const InputDecoration(
                    labelText: "ID Usuario",
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (v) => clienteID = v,
                ),

                const SizedBox(height: 10),

                /// SERVICIO
                TextField(
                  decoration: const InputDecoration(
                    labelText: "ID Servicio",
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (v) => servicioID = v,
                ),

                const SizedBox(height: 10),

                /// VEHICULO
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Vehículo",
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: (v) => tipoVehiculo = v.toLowerCase(),
                ),

                const SizedBox(height: 10),

                /// FECHA
                ElevatedButton(
                  onPressed: () async {
                    final f = await showDatePicker(
                      context: ctx,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );

                    if (f != null) fecha = f;
                  },
                  child: const Text("Elegir Fecha"),
                ),

                const SizedBox(height: 20),

                /// HORAS
                Wrap(
                  spacing: 10,
                  children: [
                    "08:00","09:00","10:00","11:00",
                    "12:00","14:00","15:00","16:00",
                  ].map((h) {
                    return ChoiceChip(
                      label: Text(h),
                      selected: hora == h,
                      selectedColor: Colors.lightBlue,
                      onSelected: (_) => setState(() => hora = h),
                    );
                  }).toList(),
                )
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () async {
                if (clienteID.isEmpty ||
                    servicioID.isEmpty ||
                    tipoVehiculo.isEmpty ||
                    fecha == null ||
                    hora == null) return;

                final fechaBD = DateFormat("yyyy-MM-dd").format(fecha!);

                final ok = await TurnosAdminService.agregarTurno(
                  idUsuario: int.parse(clienteID),
                  idServicio: int.parse(servicioID),
                  fecha: fechaBD,
                  hora: hora!,
                  tipoVehiculo: tipoVehiculo,
                );

                if (ok) {
                  Navigator.pop(ctx);
                  _refresh();
                }
              },
              child: const Text("Guardar",
                  style: TextStyle(color: Colors.lightBlue)),
            ),
          ],
        );
      },
    );
  }
}

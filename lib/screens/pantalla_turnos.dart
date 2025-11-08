import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../turnos_data.dart';

class PantallaTurnos extends StatefulWidget {
  const PantallaTurnos({Key? key}) : super(key: key);

  @override
  State<PantallaTurnos> createState() => _PantallaTurnosState();
}

class _PantallaTurnosState extends State<PantallaTurnos> {
  List turnos = List.from(turnosGlobal);

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

                  const Row(
                    children: [
                      Icon(Icons.calendar_month,
                          color: Color(0xFF00BFFF), size: 30),
                      SizedBox(width: 10),
                      Text("Turnos Reservados",
                          style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFF00BFFF),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Expanded(
                    child: ListView.builder(
                      itemCount: turnos.length,
                      itemBuilder: (_, i) {
                        final t = turnos[i];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF112233),
                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${t["cliente"]}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),

                                  Text("Hora: ${t["hora"]}",
                                      style: const TextStyle(
                                          color: Colors.white70)),

                                  Text("Servicio: ${t["servicio"]}",
                                      style: const TextStyle(
                                          color: Colors.white70)),

                                  Text("Fecha: ${t["fecha"]}",
                                      style: const TextStyle(
                                          color: Colors.white70)),
                                ],
                              ),

                              const Text(
                                "Confirmado",
                                style: TextStyle(
                                    color: Color(0xFF00BFFF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BFFF),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _agregarTurno,
                      child: const Text(
                        "Agregar",
                        style: TextStyle(color: Colors.white, fontSize: 18),
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

  void _agregarTurno() async {
    String nombre = "";
    String servicio = "";
    String? hora;
    DateTime? fecha;

    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF112233),
          title: const Text("Nuevo Turno",
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                decoration: const InputDecoration(
                  labelText: "Nombre",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => nombre = v,
              ),

              const SizedBox(height: 10),

              TextField(
                decoration: const InputDecoration(
                  labelText: "Servicio",
                  labelStyle: TextStyle(color: Colors.white70),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (v) => servicio = v,
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: () async {
                  final seleccion = await showDatePicker(
                    context: ctx,
                    locale: const Locale("es", "ES"),
                    initialDate: DateTime(2025, 10, 21),
                    firstDate: DateTime(2025, 1, 1),
                    lastDate: DateTime(2025, 12, 31),
                  );

                  if (seleccion != null) fecha = seleccion;
                },
                child: const Text("Seleccionar Fecha"),
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  "08:00","09:00","10:00","11:00",
                  "12:00","14:00","15:00","16:00",
                ].map((h) {
                  return GestureDetector(
                    onTap: () => hora = h,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16)),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child:
                  const Text("Cancelar", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                if (nombre.isEmpty ||
                    servicio.isEmpty ||
                    fecha == null ||
                    hora == null) return;

                setState(() {
                  turnos.add({
                    "cliente": nombre,
                    "servicio": servicio,
                    "fecha":
                        "${fecha!.year}-${fecha!.month}-${fecha!.day}",
                    "hora": hora!,
                  });
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
}

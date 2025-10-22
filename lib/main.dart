import 'package:flutter/material.dart';
import 'screens/pantalla_inicio.dart';
import 'screens/theme/theme.dart';

void main() {
  runApp(const LavaderoAdminApp());
}

class LavaderoAdminApp extends StatelessWidget {
  const LavaderoAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lava App',
      theme: LavaderoTheme.darkTheme,
      home: const PantallaInicio(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      debugShowCheckedModeBanner: false,
      theme: LavaderoTheme.darkTheme,

      // ✅ Soporte para español en los DatePicker y textos
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'), // Español
        Locale('en'), // Inglés (por si lo necesitás)
      ],

      home: const PantallaInicio(),
    );
  }
}

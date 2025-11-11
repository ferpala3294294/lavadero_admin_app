import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ✅ Pantalla inicio (tu pantalla principal)
import 'screens/pantalla_inicio.dart';

// ✅ Theme
import 'screens/theme/theme.dart';

// ✅ Pantalla estadísticas (solo el import, no tocamos nada más)
import 'screens/pantalla_estadisticas.dart';

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

      // ✅ Soporte para español
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
      ],

      home: const PantallaInicio(),
    );
  }
}

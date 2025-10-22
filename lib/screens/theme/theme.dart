import 'package:flutter/material.dart';

class LavaderoTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A192F), // Fondo azul oscuro
      primaryColor: const Color(0xFF00BFFF), // Celeste para acentos
      hintColor: const Color(0xFFCBD5E1), // Gris claro

      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFCBD5E1)),
        bodyMedium: TextStyle(color: Color(0xFFCBD5E1)),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0A192F),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white),
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: Color(0xFFCBD5E1),
        textColor: Color(0xFFCBD5E1),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00BFFF),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),

      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF1E293B),
        hintStyle: TextStyle(color: Color(0xFFCBD5E1)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00BFFF), width: 2),
        ),
      ),
    );
  }
}

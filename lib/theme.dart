import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'montserrat',
      primaryColor: const Color(0xFF001F3E), // Cor primária
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF001F3E), // Cor primária
        secondary: Color(0xFF446D9D), // Cor secundária
        error: Color(0xFFD11111), // Cor de erro
        background: Color(0xFFE1E1E1), // Cor de fundo
        onPrimary: Color(0xFFF5F5F5), // Cor do texto dos botões
        onSecondary: Color(0xFF202123), // Cor do texto
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, // Cor de fundo do AppBar
        titleTextStyle:
            TextStyle(color: Colors.black), // Cor do texto do AppBar
      ),
      iconTheme: const IconThemeData(color: Color(0xFF001F3E)),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF2196F3), // Cor primária
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2196F3), // Cor primária
        secondary: Color(0xFF64B5F6), // Cor secundária
        error: Color(0xFFFF5722), // Cor de erro
        background: Color(0xFF121212), // Cor de fundo
        onPrimary: Color(0xFFFFFFFF), // Cor do texto dos botões
        onSecondary: Color(0xFFFFFFFF), // Cor do texto
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF121212), // Cor de fundo do AppBar
        titleTextStyle:
            TextStyle(color: Colors.white), // Cor do texto do AppBar
        iconTheme: IconThemeData(color: Color(0xFFF5F5F5)),
      ),
    );
  }
}

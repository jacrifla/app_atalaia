import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: 'montserrat',
      primaryColor: const Color(0xFF001F3E), // Cor primária
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF001F3E), // Cor primária
        secondary: Color(0xFF001F3E), // Cor secundária
        error: Color(0xFFD11111), // Cor de erro
        background: Color(0xFFE1E1E1), // Cor de fundo
        onPrimary: Color(0xFFF5F5F5), // Cor do texto dos botões
        onSecondary: Color(0xFF446D9D), // Cor do texto
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, // Cor de fundo do AppBar
        titleTextStyle:
            TextStyle(color: Colors.black), // Cor do texto do AppBar
      ),
      iconTheme: const IconThemeData(color: Color(0xFF001F3E)),
      buttonTheme: const ButtonThemeData(disabledColor: Color(0xFFCCCCCC)),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: 'montserrat',
      primaryColor: const Color(0xFF001F3E), // Cor primária
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF64B5F6), // Cor primária equivalente ao tema light
        secondary:
            Color(0xFF64B5F6), // Cor secundária equivalente ao tema light
        error: Color(0xFFEF9A9A), // Cor de erro equivalente ao tema light
        background: Color(0xFF121212), // Cor de fundo
        onPrimary: Color(0xFF000000), // Cor do texto dos botões
        onSecondary: Color(0xFFF5F5F5), // Cor do texto
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black, // Cor de fundo do AppBar
        titleTextStyle:
            TextStyle(color: Colors.white), // Cor do texto do AppBar
      ),
      iconTheme: const IconThemeData(color: Color(0xFF001F3E)),
      buttonTheme: const ButtonThemeData(disabledColor: Color(0xFF999999)),
    );
  }
}

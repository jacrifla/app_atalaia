import 'package:flutter/material.dart';

// Definindo as cores do aplicativo
const principalColor = Color(0xFF001F3E);
const secondColor = Color(0xFF446D9D);
const error = Color(0xFF7E0000);
const backgroundColor = Color(0xFFE1E1E1);
const cardsColor = Color(0xFFFFFFFF);
const fontFamily = 'montserrat';
const disable = Color(0xFFCCCCCC);

// Definindo o tema do aplicativo
final appTheme = ThemeData(
  iconTheme: const IconThemeData(color: principalColor),
  fontFamily: fontFamily,
  colorScheme: ColorScheme.fromSeed(seedColor: principalColor),
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: principalColor,
  primaryColorLight: secondColor,
  buttonTheme: const ButtonThemeData(
    buttonColor: principalColor,
    textTheme: ButtonTextTheme.primary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(principalColor),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: principalColor)),
      foregroundColor: MaterialStateProperty.all<Color>(principalColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(principalColor),
      foregroundColor: MaterialStateProperty.all<Color>(backgroundColor),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return secondColor;
      }
      return disable;
    }),
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return secondColor;
      }
      return disable;
    }),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: principalColor,
    foregroundColor: backgroundColor,
  ),
  useMaterial3: true,
  cardTheme: const CardTheme(
    color: cardsColor,
  ),
);

import 'package:flutter/material.dart';

Map<int, Color> _swatchOpacity = {
  50: const Color.fromRGBO(213, 180, 126, 0.1),
  100: const Color.fromRGBO(213, 180, 126, .2),
  200: const Color.fromRGBO(213, 180, 126, .3),
  300: const Color.fromRGBO(213, 180, 126, 1),
  400: const Color.fromRGBO(76, 11, 28, .5),
  500: const Color.fromRGBO(76, 11, 28, .6),
  600: const Color.fromRGBO(76, 11, 28, .7),
  700: const Color.fromRGBO(76, 11, 28, .8),
  800: const Color.fromRGBO(76, 11, 28, .9),
  900: const Color.fromRGBO(76, 11, 28, 1),
};

abstract class CustomColors {
  static Color customContrastColor = Colors.red.shade700;

  static MaterialColor customSwatchColor =
  MaterialColor(0xD5B47E, _swatchOpacity);
}
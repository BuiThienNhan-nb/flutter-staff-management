import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hexcolor/hexcolor.dart';

class Palette {
  static const Color darkBlue = Color(0xff092E34);
  static const Color lightBlue = Color(0xff489FB5);
  static const Color orange = Color(0xffFFA62B);
  static const Color darkOrange = Color(0xffCC7700);
  static const Color myLightGrey = Color(0xFFE7EBEE);
  static Color myColor = HexColor('#ff5c01');

  //0xFFF3F5F7           0xFFE7EBEE

  // Print int value for Color() from hex string
  void hexToColor(String code) {
    print('COLOR: ${int.parse(code.substring(1, 7), radix: 16) + 0xFF000000}');
  }

  static const MaterialColor myOrangeMaterialColor = const MaterialColor(
    4294925313 + 0xFF000000,
    const <int, Color>{
      50: const Color(4294925313 + 0xFF000000),
      100: const Color(4294925313 + 0xFF000000),
      200: const Color(4294925313 + 0xFF000000),
      300: const Color(4294925313 + 0xFF000000),
      400: const Color(4294925313 + 0xFF000000),
      500: const Color(4294925313 + 0xFF000000),
      600: const Color(4294925313 + 0xFF000000),
      700: const Color(4294925313 + 0xFF000000),
      800: const Color(4294925313 + 0xFF000000),
      900: const Color(4294925313 + 0xFF000000),
    },
  );

  static const MaterialColor orangeMaterialColor = const MaterialColor(
    4294944299 + 0xFF000000,
    const <int, Color>{
      50: const Color(4294944299 + 0xFF000000),
      100: const Color(4294944299 + 0xFF000000),
      200: const Color(4294944299 + 0xFF000000),
      300: const Color(4294944299 + 0xFF000000),
      400: const Color(4294944299 + 0xFF000000),
      500: const Color(4294944299 + 0xFF000000),
      600: const Color(4294944299 + 0xFF000000),
      700: const Color(4294944299 + 0xFF000000),
      800: const Color(4294944299 + 0xFF000000),
      900: const Color(4294944299 + 0xFF000000),
    },
  );
}

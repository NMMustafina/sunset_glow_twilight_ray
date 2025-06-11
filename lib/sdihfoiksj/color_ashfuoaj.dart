import 'package:flutter/material.dart';

abstract class Colorasdf {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFFF8F7F2);
  static const Color appp = Color(0xFF1E1E1E);
  static const Color blue = Color(0xFF313BD4);
  static const Color bg2 = Color(0xFFE3E2DD);
  static const Color primary = Color(0xFF252525);
  static const Color accentStart = Color(0xFFFC466C);
  static const Color accentEnd = Color(0xFFF31BAA);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentStart, accentEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

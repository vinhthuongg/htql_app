import 'package:flutter/material.dart';

class AppColor {
  static const Color toyotaRed = Color(0xFFE50012);
  static const Color toyotaRedDark = Color(0xFFB4000F);
  static const Color black = Color(0xFF111111);
  static const Color charcoal = Color(0xFF2B2F33);
  static const Color grey = Color(0xFF70757A);
  static const Color lightGrey = Color(0xFFD0D5DA);
  static const Color background = Color(0xFFF8F6FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF0F2F4);
  static const Color white = Color(0xFFFFFFFF);
  static const Color shadow = Color(0x1A111111);

  static const Color darkSurface = Color(0xFF111111);
  static const Color darkSurfaceMuted = Color(0xFF262626);
  static const Color darkSurfaceElevated = Color(0xFF303030);
  static const Color darkBorder = Color(0xFF5A5A5A);
  static const Color darkTextMuted = Color(0xFFB8B8B8);

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color cardColor(BuildContext context) {
    return isDarkMode(context) ? darkSurface : surface;
  }

  static Color mutedCardColor(BuildContext context) {
    return isDarkMode(context) ? darkSurfaceMuted : surfaceMuted;
  }

  static Color elevatedCardColor(BuildContext context) {
    return isDarkMode(context) ? darkSurfaceElevated : surface;
  }

  static Color borderColor(BuildContext context) {
    return isDarkMode(context) ? darkBorder : lightGrey;
  }

  static Color primaryTextColor(BuildContext context) {
    return isDarkMode(context) ? white : black;
  }

  static Color secondaryTextColor(BuildContext context) {
    return isDarkMode(context) ? darkTextMuted : grey;
  }
}

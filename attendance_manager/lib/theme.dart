// ignore_for_file: deprecated_member_use

import 'package:attendance_manager/constants.dart' as constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static bool isLightTheme = true;

  static ThemeData getTheme() {
    if (isLightTheme) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline6: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: base.headline6!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      subtitle1: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.subtitle1!.color, fontSize: 18)),
      subtitle2: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: base.subtitle2!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      bodyText2: GoogleFonts.nunito(
          textStyle: TextStyle(
        color: base.bodyText2!.color,
        fontSize: 18,
        // fontWeight: FontWeight.w700
      )),
      bodyText1: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.bodyText1!.color, fontSize: 16)),
      button: GoogleFonts.nunito(
          textStyle: TextStyle(
              color: base.button!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      caption: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.caption!.color, fontSize: 16)),
      headline4: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.headline4!.color, fontSize: 34)),
      headline3: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.headline3!.color, fontSize: 48)),
      headline2: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.headline2!.color, fontSize: 60)),
      headline1: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.headline1!.color, fontSize: 96)),
      headline5: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.headline5!.color, fontSize: 24)),
      overline: GoogleFonts.nunito(
          textStyle: TextStyle(color: base.overline!.color, fontSize: 10)),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(constants.primaryColorString);
    Color secondaryColor = HexColor(constants.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
        appBarTheme: AppBarTheme(
          color: primaryColor,
        ),
        popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
        primaryColor: primaryColor,
        buttonColor: HexColor("#FDBD00"),
        splashColor: Colors.white.withOpacity(0.1),
        hoverColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        highlightColor: Colors.transparent,
        canvasColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        errorColor: HexColor("#CA443C"),

        // buttonTheme: _buttonThemeData(colorScheme),
        // dialogTheme: _dialogTheme(),
        // cardTheme: _cardTheme(),
        textTheme: _buildTextTheme(base.textTheme),
        primaryTextTheme: _buildTextTheme(base.textTheme),
        platform: TargetPlatform.iOS,
        indicatorColor: primaryColor,
        disabledColor: HexColor("#D5D7D8"), colorScheme: colorScheme.copyWith(secondary: HexColor("#48BF84")));
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(constants.primaryColorString);
    Color secondaryColor = HexColor(constants.secondaryColorString);
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      popupMenuTheme: const PopupMenuThemeData(color: Colors.black),
      appBarTheme: const AppBarTheme(color: Colors.black),
      dividerColor: HexColor("#F1F1F1"),
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: Colors.grey[850],
      scaffoldBackgroundColor: Colors.grey[850],
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS, colorScheme: colorScheme.copyWith(secondary: secondaryColor),
    );
  }

//   static ButtonThemeData _buttonThemeData(ColorScheme colorScheme) {
//     return ButtonThemeData(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(4.0),
//       ),
//       colorScheme: colorScheme,
//       textTheme: ButtonTextTheme.primary,
//     );
//   }

//   static DialogTheme _dialogTheme() {
//     return DialogTheme(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//     );
//   }

//   static CardTheme _cardTheme() {
//     return CardTheme(
//       clipBehavior: Clip.antiAlias,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       elevation: 4,
//       margin: EdgeInsets.all(0),
//     );
//   }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

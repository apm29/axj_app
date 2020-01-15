import 'package:flutter/material.dart';

///
/// author : ciih
/// date : 2020-01-10 13:22
/// description :
///
const kShrinePink50 = const Color(0xFFFEEAE6);
const kShrinePink100 = const Color(0xFFFEDBD0);
const kShrinePink300 = const Color(0xFFFBB8AC);
const kShrinePink400 = const Color(0xFFEAA4A4);

const kShrineBrown900 = const Color(0xFF442B2D);

const kShrineErrorRed = const Color(0xFFC5032B);

const kShrineSurfaceWhite = const Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;

ThemeData lightData = ThemeData.light().copyWith(
  platform: TargetPlatform.iOS,
  accentColor: kShrineBrown900,
  primaryColor: kShrinePink100,
  buttonColor: kShrinePink100,
  scaffoldBackgroundColor: kShrineBackgroundWhite,
  cardColor: kShrineBackgroundWhite,
  textSelectionColor: kShrinePink100,
  errorColor: kShrineErrorRed,
);

ThemeData twitterLight = ThemeData(
  platform: TargetPlatform.iOS,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: Color(0xffffffff),
    iconTheme: IconThemeData(
      color: Color(0xff1a7fd5),
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xff1a7fd5),
    ),
    textTheme: TextTheme(),
  ),
  applyElevationOverlayColor: true,
  primaryColor: Color(0xffffffff),
  primaryColorBrightness: Brightness.light,
  primaryColorLight: Color(0xffdfe8f3),
  primaryColorDark: Color(0xfffdfdfd),
  accentColor: Color(0xff1a7fd5),
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xfffdfdfd),
  scaffoldBackgroundColor: Color(0xfffdfdfd),
  iconTheme: IconThemeData(
    color: Color(0xff1a7fd5),
  ),
);

ThemeData twitterDark = ThemeData(
  brightness: Brightness.dark,
  platform: TargetPlatform.iOS,
  appBarTheme: AppBarTheme(
    brightness: Brightness.dark,
    color: Color(0xff111820),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(),
  ),
  applyElevationOverlayColor: true,
  primaryColor: Color(0xff131d27),
  primaryColorBrightness: Brightness.dark,
  primaryColorLight: Color(0xff2f4254),
  primaryColorDark: Color(0xff111820),
  accentColor: Color(0xff1a7fd5),
  accentColorBrightness: Brightness.dark,
  canvasColor: Color(0xff111820),
  scaffoldBackgroundColor: Color(0xff111820),
  cardColor: Color(0xff1c162e),
  cardTheme: CardTheme(
    clipBehavior: Clip.antiAlias,
    color: Color(0xff1c162e),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    ),
  ),
  textTheme: TextTheme(overline: TextStyle(color: Color(0xffa0a9b2))),
  colorScheme: ColorScheme(
    primary: Color(0xffffffff),
    primaryVariant: Color(0xff111820),
    secondary: Color(0xff1a7fd5),
    secondaryVariant: Color(0xff4755ef),
    onPrimary: Colors.white,
    onBackground: Color(0xff1a7fd5),
    onError: Colors.white,
    brightness: Brightness.dark,
    onSurface: Color(0xffa0a9b2),
    onSecondary: Colors.white,
    surface: Color(0xff1c162e),
    background: Color(0xff332d43),
    error: Color(0xffed457d),
  ),

  pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.macOS:OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS:OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.android:OpenUpwardsPageTransitionsBuilder(),
      }
  )
);

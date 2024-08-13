import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getDarkThemeData() {
  return ThemeData(
    colorScheme: getDarkColorScheme(),
    textTheme: getDarkThemeTextStyle(),
    scaffoldBackgroundColor: getDarkColorScheme().background,
    scrollbarTheme: ScrollbarThemeData(
      crossAxisMargin: 20.5,
      mainAxisMargin: 20,
      interactive: true,
      thumbVisibility: MaterialStateProperty.resolveWith((states) => true),
      trackVisibility: MaterialStateProperty.resolveWith((states) => true),
      trackColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.dragged)) {
          return Colors.white.withOpacity(
            0.5,
          ); // The thumb will be red when dragged
        }
        return Colors.white.withOpacity(
          0.3,
        ); // The default thumb color
      }),
      radius: const Radius.circular(10),
      thumbColor: MaterialStateProperty.resolveWith(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.dragged)) {
            return kPrimaryColor; // The thumb will be red when dragged
          }
          return kPrimaryColor.withOpacity(
            0.5,
          ); // The default thumb color
        },
      ),
    ),
    iconTheme: IconThemeData(
      color: getDarkColorScheme().onBackground,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getDarkThemeTextStyle().displayMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: kOnPrimary,
            fontFamily: "calibri"),
        backgroundColor: Colors.cyan,
        foregroundColor: kOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
      ),
    ),
    inputDecorationTheme: getDarkInputDecoTheme(),
  );
}

InputDecorationTheme getDarkInputDecoTheme() {
  return InputDecorationTheme(
    filled: true,
    floatingLabelAlignment: FloatingLabelAlignment.start,

    fillColor: getDarkColorScheme().onBackground,
    border: InputBorder.none,
    alignLabelWithHint: true,

    /// this for it when it be Hint
    labelStyle: getDarkThemeTextStyle().displayMedium!.copyWith(
          color: kPrimaryColor.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),

    /// this for it when it be Label
    floatingLabelStyle: getDarkThemeTextStyle().displayMedium!.copyWith(
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),

    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          12,
        ),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          12,
        ),
      ),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          12,
        ),
      ),
      borderSide: BorderSide(color: getLightColorScheme().error),
    ),
  );
}

TextTheme getDarkThemeTextStyle() {
  return TextTheme(
    displayLarge: TextStyle(
      color: getDarkColorScheme().onBackground,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: "calibri",
    ),
    displayMedium: TextStyle(
      color: getDarkColorScheme().onBackground,
      fontSize: 16,
      fontFamily: "calibri",
    ),
    displaySmall: TextStyle(
      color: getDarkColorScheme().onBackground,
      fontSize: 10,
      fontFamily: "calibri",
    ),
  );
}

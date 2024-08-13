import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:flutter/material.dart';

ThemeData getLightThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: getLightColorScheme().background,
    colorScheme: getLightColorScheme(),
    textTheme: getLightThemeTextStyle(),
    iconTheme: IconThemeData(
      color: getLightColorScheme().onBackground,
    ),
    inputDecorationTheme: getLightInputDecoTheme(),
    scrollbarTheme: ScrollbarThemeData(
      crossAxisMargin: 5,
      mainAxisMargin: 5,
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getLightThemeTextStyle().displayMedium!.copyWith(
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
  );
}

InputDecorationTheme getLightInputDecoTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: getLightColorScheme().background,
    border: InputBorder.none,
    alignLabelWithHint: true,

    /// this for it when it be Hint
    labelStyle: getLightThemeTextStyle().displayMedium!.copyWith(
          color: kPrimaryColor.withOpacity(0.6),
          fontWeight: FontWeight.bold,
        ),

    /// this for it when it be Label
    floatingLabelStyle: getLightThemeTextStyle().displayMedium!.copyWith(
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

    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          12,
        ),
      ),
      borderSide: BorderSide(color: getLightColorScheme().error),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          12,
        ),
      ),
      borderSide: BorderSide.none,
    ),
  );
}

TextTheme getLightThemeTextStyle() {
  return TextTheme(
    bodyMedium: TextStyle(color: getLightColorScheme().onPrimary),
    displayLarge: TextStyle(
      color: getLightColorScheme().onBackground,
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontFamily: "calibri",
    ),
    displayMedium: TextStyle(
      color: getLightColorScheme().onBackground,
      fontSize: 16,
      fontFamily: "calibri",
    ),
    displaySmall: TextStyle(
      color: getLightColorScheme().onBackground,
      fontSize: 10,
      fontFamily: "calibri",
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

const kPrimaryColor = Color(0xff002E94);
Color kSecondaryColor = HexColor('#45474B');
const kOnPrimary = Colors.white;
const kBlPrimary = Colors.black;
ColorScheme getLightColorScheme() {
  return  ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: kPrimaryColor,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: kPrimaryColor,
    surface: Color.fromARGB(255, 255, 255, 255),
    shadow: kPrimaryColor,
    onSurface: kSecondaryColor,
  );
}

ColorScheme getDarkColorScheme() {
  return  ColorScheme(
    brightness: Brightness.dark,
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: kPrimaryColor,
    error: Colors.red,
    onError: Colors.white,
    background: Color(0xff001B58),
    onBackground: kOnPrimary,
    surface: kPrimaryColor,
    surfaceTint: kOnPrimary,
    shadow: kOnPrimary,
    onSurface: Colors.white,
  );
}

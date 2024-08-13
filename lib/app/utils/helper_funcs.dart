import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations getL10(context) {
  return AppLocalizations.of(context)!;
}

Size getScreenSize(context) {
  return MediaQuery.of(context).size;
}

double getScreenHeight(context) {
  return getScreenSize(context).height;
}

double getScreenWidth(context) {
  return getScreenSize(context).width;
}

SizedBox getHeightSpace(double height) {
  return SizedBox(
    height: height,
  );
}

getTopPadding(context) {
  return MediaQuery.paddingOf(context).top;
}

SizedBox getWidthSpace(double width) {
  return SizedBox(
    width: width,
  );
}

ThemeData getThemeData(context) => Theme.of(context);

List<BoxShadow> getBoxShadow(BuildContext context, {Color? color}) {
  color ??= getThemeData(context).colorScheme.onBackground.withOpacity(0.3);
  return [
    BoxShadow(
      color: color, //Colors.grey.withOpacity(0.5),
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3), // changes position of shadow
    ),
  ];
}

Color getRandomQuietColor() {
  // List of quiet colors
  List<Color> quietColors = [
    Colors.blueGrey,
    Colors.indigo,
    Colors.teal,
    Colors.amber,
    Colors.pink,
    Colors.brown,
    Colors.deepPurple,
    Colors.green,
   Colors.black
  ];

  // Generate a random index
  int randomIndex = Random().nextInt(quietColors.length);

  // Return the selected color
  return quietColors[randomIndex];
}


bool isHTMLTag(String str) {
  final RegExp htmlTagRegex = RegExp(r'<[^>]*>');
  return htmlTagRegex.hasMatch(str);
}

String truncateString(String str, int maxLength) {
  if (str.length <= maxLength) {
    return str;
  } else {
    return '${str.substring(0, maxLength)}...';
  }
}
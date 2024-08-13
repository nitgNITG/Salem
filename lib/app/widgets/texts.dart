import 'package:flutter/material.dart';
import '../core/themes/colors.dart';
import '../utils/helper_funcs.dart';

Text getTitleText(
  String text,
  BuildContext context, {
  Color color = kPrimaryColor,
  double? size,
  FontWeight weight = FontWeight.bold,
}) {
  return Text(
    text,
    style: getThemeData(context).textTheme.displayLarge!.copyWith(
          height: 1.2,
          color: color,
          fontSize: size,
          fontWeight: weight,
        ),
  );
}

Text getNormalText(
  String? text,
  BuildContext context, {
  Color? color,
  FontWeight? weight,
  double? size,
  TextAlign? align,
  String? family,
  bool?     underline
}) {
  return Text(
    text ?? "",
    style: getThemeData(context).textTheme.displayMedium!.copyWith(
          height: 1.5,fontFamily: family,
          color: color ?? getThemeData(context).colorScheme.onBackground,
          fontWeight: weight ?? FontWeight.normal,
          fontSize: size, decoration:underline!=null? TextDecoration.underline:null,
      decorationColor: color
        ),
    textAlign: align,
  );
}

import 'package:flutter/material.dart';

InputDecoration getDecoration(InputDecorationTheme theme) {
  // Create a new InputDecoration object based on the given theme.
  InputDecoration decoration = InputDecoration(
    border: theme.border,
    focusedBorder: theme.enabledBorder,
    enabledBorder: theme.enabledBorder,
    disabledBorder: theme.disabledBorder,
    errorBorder: theme.errorBorder,
    focusedErrorBorder: theme.errorBorder,
    contentPadding: theme.contentPadding,
    isDense: theme.isDense,
    labelStyle: theme.labelStyle,
    counterStyle: theme.counterStyle,
  );

  // Return the new InputDecoration object.
  return decoration;
}

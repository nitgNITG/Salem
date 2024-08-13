import 'package:flutter/material.dart';

class ScreenSizeConstants {
  static const kNewsBarHeight = 0.010;
  static const kBottomBarHeightPercent = 0.091;
  static getBottomNavBarHeight(context) {
    return MediaQuery.of(context).size.height * kBottomBarHeightPercent;
  }
  
}

import 'package:flutter/material.dart';

import '../../utils/helper_funcs.dart';



Positioned getAppPostionedBackground(BuildContext context) {
  getRandomQuietColor();
  return Positioned(
    bottom: 0,
    left: 0,
    width: getScreenSize(context).width,
    height: getScreenHeight(context),
    // right: 1,
    // top: 0,
    child: Container(
      color: getThemeData(context).colorScheme.background,
      /*   child: SvgPicture.asset(
        "assets/images/app_bg.svg",
        height:
            getScreenSize(context).height - MediaQuery.paddingOf(context).top,
        width: getScreenSize(context).width,
        fit: BoxFit.fill,
        colorFilter: ColorFilter.mode(
          getBackColor(context),
          BlendMode.srcIn,
        ),
      ), */
    ),
  );
}

Color getBackColor(context) {
  if (getThemeData(context).brightness == Brightness.light) {
    return getThemeData(context).colorScheme.onBackground.withOpacity(0.09);
  } else {
    return getThemeData(context).colorScheme.onBackground.withOpacity(0.06);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global_providers/localization_provider.dart';

Route routeToPage(Widget page2) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page2,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final isEnglish =
          Provider.of<LocalizationProvider>(context, listen: false)
                  .getAppLocale()
                  .languageCode ==
              "ar";
      final begin =
          isEnglish ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);
      final end = isEnglish ? const Offset(0.0, 0.0) : const Offset(0.0, 0.0);
      //
      // const begin = Offset(1.0, 1.0);
      // const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

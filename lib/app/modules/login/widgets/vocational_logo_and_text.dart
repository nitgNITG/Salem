import 'package:flutter/material.dart';

import '../../../utils/helper_funcs.dart';

class MinistryLogoAndVocationalText extends StatelessWidget {
  const MinistryLogoAndVocationalText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: getScreenSize(context).height * 0.0,
      width: getScreenSize(context).width,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getHeightSpace(MediaQuery.paddingOf(context).top),
          Image.asset(
            "assets/images/app_logo.png",
            width: getScreenWidth(context) * 0.50,
            height: getScreenHeight(context) * 0.16,
            fit: BoxFit.fill,
          ),                                                       /// صوره اللوجو اللي في الصوره اللي في صفحه تسجيل الدخول
          getHeightSpace(10),
          /*       Column(
            children: [
              Text(
                getL10(context).vocationalTrainingAcademy,
                textAlign: TextAlign.center,
                style: getThemeData(context).textTheme.displayLarge!.copyWith(
                      color: getThemeData(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
              ),
              Text(
                getL10(context).academy,
                style: getThemeData(context).textTheme.displayLarge!.copyWith(
                      color: getThemeData(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w900,
                      height: 1.3,
                    ),
              )
            ],
          ),
      */
        ],
      ),
    );
  }
}

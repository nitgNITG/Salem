import 'package:flutter/material.dart';

import '../utils/helper_funcs.dart';

class MinistryLogoHorizontalWithName extends StatelessWidget {
  const MinistryLogoHorizontalWithName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getWidthSpace(5),
        Image.asset(
          "assets/images/app_logo.png",
          width: 50,
          height: 50,
          fit: BoxFit.fill,
        ),
        getWidthSpace(5),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            getHeightSpace(5),
            Text(
              getL10(context).ministryOfManpower,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  height: 0.8),
            ),
            Text(
              getL10(context).vocationalTrainingAcademy,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 12,
                  ),
            ),
          ],
        )
      ],
    );
  }
}

class VocationalAcademyHorizontalRegister extends StatelessWidget {
  const VocationalAcademyHorizontalRegister({
    super.key,
    this.heightPercent = 0.15,  this.show=true,
  });
  final double heightPercent;
  final bool show;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenHeight(context) * heightPercent,
      width: getScreenWidth(context),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/Asset 3@100x 1 (1).png",
              width: getScreenWidth(context) * 0.7,
              fit: BoxFit.fill,
            ),
          ),
          if(show)
          Center(
            child: Image.asset(
              "assets/images/Group 421 (1).png",
              width: getScreenWidth(context) * 0.7,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/helper_funcs.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // This allows the body to extend behind the AppBar
      extendBodyBehindAppBar: true,
      // This allows the body to extend behind the AppBar
      backgroundColor: getThemeData(context).colorScheme.background,

      body: Stack(
        // fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: SvgPicture.asset(
              'assets/images/app_bg.svg',
              height: getScreenSize(context).height * 0.9,
              colorFilter: ColorFilter.mode(
                  getThemeData(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.2),
                  BlendMode.srcIn),
              width: getScreenSize(context).width,
              fit: BoxFit.fill,
            ),
          ),                                                        /// صوره الخلفيه بتاعه الصفحه
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getHeightSpace(getScreenSize(context).height * 0.05),
                  Container(
                    height: getScreenSize(context).height * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: getThemeData(context).colorScheme.background,
                      shape: BoxShape.circle,
                      boxShadow: getBoxShadow(context),
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/images/no_internet.png",
                        ),
                      ),
                    ),
                  ),                                                  /// صوره النت مفصول
                  getHeightSpace(20),
                  getTitleText(                                                    /// كلمه please confirm
                    getL10(context).pleaseConfirm,
                    context,
                    size: 34,
                    weight: FontWeight.bold,
                    color: getThemeData(context).colorScheme.onBackground,
                  ),
                  getHeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getTitleText(
                            getL10(context).thereIsInternetConnection,
                            context,
                            size: 25,
                            color:
                            getThemeData(context).colorScheme.onBackground,
                          ),
                        ),
                      ),                                                /// كلمه مفيش اتصال بالانترنت
                    ],
                  ),
                  getHeightSpace(
                    getScreenSize(context).height * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end:  Alignment.bottomRight,
                            colors: [
                              Color(0xff002E94),
                              Color(0xff00FFFF)
                            ]
                        )
                    ),
                    child: TextButton(
                      onPressed: (){},
                      child: Text(
                        getL10(context).tryAgain,
                        style: TextStyle(
                          color: kOnPrimary,
                        ),
                      ),
                    ),
                  ),                                                  /// زرار try again
                  getHeightSpace(
                    getScreenSize(context).height * 0.075,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/app_logo.png",
                        height: getScreenSize(context).height * 0.15,
                      ),
                      getWidthSpace(10),
                    ],
                  ),                                                        /// تحت الزرار في صوره
                ],
              ),
            ),
          )                                                              /// عناصر الصفحه نفسها
        ],
      ),
    );
  }
}

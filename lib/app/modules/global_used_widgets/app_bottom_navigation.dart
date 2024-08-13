
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/home/main_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../global_providers/localization_provider.dart';
import '../../core/constants_and_enums/screen_size_constants.dart';
import '../../utils/helper_funcs.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late final MainAppController controller;

  @override
  void initState() {
    controller = Provider.of<MainAppController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.currentPageIndex,
      builder: (context, pageIndex, child) {
        Provider.of<LocalizationProvider>(context, listen: true);
        return AnimatedContainer(
          padding: EdgeInsets.only(top:   getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.01:getScreenWidth(context)*0.01),
          height:  getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.1:getScreenWidth(context)*0.1,
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 500),
           color: HexColor('#45474B'),
          width: getScreenSize(context).width,
          ///  here check if the user is guest to not show the bottom navigationBar
          child: Row(
            mainAxisAlignment: controller.getIsUserGuest()
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (controller.getIsUserGuest())
                ...controller
                    .bottomBarListForGuest()
                    .map((e) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        color:Colors.transparent,
                        padding: pageIndex == e["index"]
                            ? const EdgeInsets.symmetric(
                          horizontal: 10,
                        )
                            : const EdgeInsets.symmetric(horizontal: 0),
                        height:
                        ScreenSizeConstants.getBottomNavBarHeight(
                            context) *
                            0.6,
                        child: Image.asset(
                          e["icon"].toString(),
                          color: pageIndex == e["index"]
                                ? HexColor('#F4CE14')
                                : kOnPrimary,
                          /* height:
                                      ScreenSizeConstants.getBottomNavBarHeight(
                                              context) *
                                          0.6,*/
                        ),
                      ),
                      const Spacer(),
                      Text(
                        e["name"].toString(),
                        style: const TextStyle(
                          height: 0.9,fontFamily: 'Bold'
                          // color: pageIndex == e["index"]?kSecondaryColor:null
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ).onTap(() {
                  controller.setPage(e["index"]);
                }))
                    .toList()
              else
                ...controller
                    .bottomBarList()
                    .map((e) => AnimatedContainer(
                  // color: getRandomQuietColor(),
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        color: Colors.transparent,
                        padding: pageIndex == e["index"]
                            ? const EdgeInsets.symmetric(
                          horizontal: 10,
                        )
                            : const EdgeInsets.symmetric(horizontal: 0),
                        height:
                        ScreenSizeConstants.getBottomNavBarHeight(
                            context) *
                            0.6,
                        child: Image.asset(
                          e["icon"].toString(),
                          color: pageIndex == e["index"]
                              ? HexColor('#F4CE14')
                              : kOnPrimary,
                          /* height:
                                      ScreenSizeConstants.getBottomNavBarHeight(
                                              context) *
                                          0.6,*/
                        ),
                      ),
                      const Spacer(),
                      Text(
                        e["name"].toString(),
                        style:  TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 8,
                          height: 0.9,color: pageIndex == e["index"]
                            ? HexColor('#F4CE14')
                            : kOnPrimary,
                          // color: pageIndex == e["index"]?kSecondaryColor:null
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ).onTap(() {
                  controller.setPage(e["index"]);
                }))
                    .toList()
            ],
          ),

          //
        );
      },
    );
  }
}

import 'package:al_mariey/app/core/data/models/my_course.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_page.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global_providers/theme_provider.dart';
import '../../../utils/helper_funcs.dart';
import '../../../widgets/avatar_with_progress.dart';

class MyCourseItem extends StatelessWidget {
  const MyCourseItem({super.key, required this.item, required this.controller});

  final BaseController controller;
  final MyCourse item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: getScreenSize(context).width * 0.65,
      // height: 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (Provider.of<AppThemeProvider>(
                context,
                listen: false,
              ).getAppThemeMode() !=
              ThemeMode.dark)
            const BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
        ],
        color: getThemeData(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (item.overviewfiles.isNotEmpty)
                      AvatarWithProgressBar(
                        imageUrl:
                            "${item.overviewfiles.first.fileurl}?token=${controller.getLoggedUser().token}",

                        /// divide by 100 because its value come between 0 and 100
                        /// and the widget is recive the value between 0 and 1
                        progress: item.progress / 100,
                        width: getScreenWidth(context) * 0.12,
                        height: 40,
                      ),
                    if ((item.progress).toDouble() == 100)
                      Container(
                        width: getScreenWidth(context) * 0.12,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.5),
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      )
                  ],
                ),
              ),
              getWidthSpace(10),
              Column(
                children: [
                  getNormalText(
                      item.shortname.characters.length > 23
                          ? item.shortname.substring(0, 22)
                          : item.shortname,
                      context),
                  getHeightSpace(10),
                  Text(
                    item.fullname.characters.length > 20
                        ? item.fullname.substring(0, 19)
                        : item.fullname,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w200,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.8),
                          fontSize: 10,
                          height: 0.9,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if ((item.progress).toDouble() != 100)
                SizedBox(
                  // width: getScreenSize(context).width * 0.25,
                  child: ElevatedButton(
                    /*  style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),*/
                    onPressed: () {
                      Navigator.of(context).push(routeToPage(CourseProfilePage(
                        myCourse: item,
                      )));
                    },
                    child: getNormalText(
                        getL10(context).completeCourse, context,
                        color: kOnPrimary),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

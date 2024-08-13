import 'package:al_mariey/app/modules/course_categories/course_categories_page.dart';
import 'package:al_mariey/app/modules/my_class/my_courses_page.dart';
import 'package:al_mariey/app/modules/student_profile/profile_page.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';

import '../base/base_controller.dart';
import '../home_page/home_page.dart';

class MainAppController extends BaseController {
  List<Widget> pagesForPageView = [
    const HomePage(),
    const MyCoursesPage(),
    const StudentProfile()
  ];

  List<Widget> pagesForPageViewForGuest = [
    const HomePage(),
    const CourseCategoriesPage(),
  ];

  PageController pageViewController = PageController();

  setPage(index) {
    currentPageIndex.value = index;
    pageViewController.jumpToPage(
      index,
      // duration: const Duration(milliseconds: 100),
      // curve: Curves.bounceIn,
    );
  }

  List<Map<String, Object>> bottomBarList() => [
    Map.of({
      "icon": "assets/images/profile.png",
      "index": 2,
      "name": getL10(context!).profile,
    }),
        Map.of({
          "icon": "assets/images/home.png",
          "index": 0,
          "name": getL10(context!).home,
        }),
    Map.of({
      "icon": "assets/images/courses.png",
      "index": 1,
      "name": getL10(context!).myClass,
    }),
      ];                              /// ليسته ال bottom navigation bar العاديه

  List<Map<String, Object>> bottomBarListForGuest() => [
        Map.of({
          "icon": "assets/images/home_ic.svg",
          "index": 0,
          "name": getL10(context!).home,
        }),
        Map.of({
          "icon": "assets/images/my_class.svg",
          "index": 1,
          "name": getL10(context!).myClass,
        }),
      ];                      /// ليسته ال bottom navigation bar بتاعه ال guest

  ValueNotifier<int> currentPageIndex = ValueNotifier(0);
}

import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/data/models/my_course.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';
import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/course.dart';

class MyCoursesController extends BaseController {
  List<MyCourse> myCourses = [];
 
 
  Future<void> getEnrollCourses() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}/academyApi/json.php?function=get_enrol_courses&token=${getLoggedUser().token}",
      );
      if (response['status'] != 'fail') {
        myCourses = (response['courses'] as List)
            .map((e) {
              return MyCourse.fromJson(e);
            })
            .cast<MyCourse>()
            .toList();
       
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
    }
  }

   List<MyCourse> myCoursesFiltered = [];
  filter(String str) {
   {
      myCoursesFiltered = myCourses
          .where((element) =>
              element.fullname.contains(str) || element.shortname.contains(str))
          .toList();
    }
  }
}

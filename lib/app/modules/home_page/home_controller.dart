import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/data/api/ApiCall.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';

import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/models/category.dart';
import '../../core/data/models/my_course.dart';

class HomeController extends BaseController {
  List<AcademicStage> categoriesList = [];

  // List<MyCourse> myCoursesList = [];
  List<String> aboutAcademyVideos = [];
  List<String> aboutAcademyTeachers = [];
  List<Map<String,dynamic>> aboutAcademyFreeLessons = [];
  List<MyCourse> myCourses = [];
  List<String> aboutAcademy = [];
  var aboutAcademyState = ValueNotifier(AppViewState.busy);
  var aboutAcademyTeachersState = ValueNotifier(AppViewState.busy);
  var aboutAcademyFreeLessonsState = ValueNotifier(AppViewState.busy);
  var categoriesState = ValueNotifier(AppViewState.busy);

  String aboutAcademyDescription = "",aboutTeachersDescription = "";
  Future<void> getCategories() async {
    try {
      categoriesState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}?function=about_block&block_name=cocoon_about_1",
      );
print(response);
      if (response['state'] != 'fail') {
        aboutAcademy = [response['data']['text1'],response['data']['images'][0]];
        changeViewState(AppViewState.idle);
        categoriesState.value = AppViewState.idle;
      }

    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      categoriesState.value = AppViewState.error;
    }
  }

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

  Future<void> getAboutAcademy() async {
    try {
      aboutAcademyState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}?function=getGalleryBlockData&block_name=cocoon_gallery&id=31",
      );
      aboutAcademyVideos.clear();
        (response['data']['images'] as Map).forEach((key, value) {aboutAcademyVideos.addAll([value.toString()]); }) ;

      aboutAcademyDescription = response['data']['title'];

      changeViewState(AppViewState.idle);
      aboutAcademyState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyState.value = AppViewState.error;

    }
  }

  Future<void> getAboutAcademyTeachers() async {
    try {
      aboutAcademyTeachersState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}?function=getGalleryBlockData&block_name=cocoon_gallery&id=32",
      );
      aboutAcademyTeachers.clear();
      (response['data']['images'] as Map).forEach((key, value) {aboutAcademyTeachers.addAll([value.toString()]); }) ;

      aboutTeachersDescription=response['data']['title'];
      changeViewState(AppViewState.idle);
      aboutAcademyTeachersState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyTeachersState.value = AppViewState.error;

    }
  }

  Future<bool> getLogout(String token) async {
    try {
      aboutAcademyFreeLessonsState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "https://salem-mar3y.com/salem_apis/signleteacher/apis3.php?function=logout&token=${token}",
      );
if(response['status']=='success')
      {
        changeViewState(AppViewState.idle);
      aboutAcademyFreeLessonsState.value = AppViewState.idle;
      return true;}
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyFreeLessonsState.value = AppViewState.error;
return false;
    }
    return false;
  }

  Future<void> getAboutAcademyFreeLessons() async {
    try {
      aboutAcademyFreeLessonsState.value = AppViewState.busy;
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "${StaticData.baseUrl}?function=all_courses",
      );

      aboutAcademyFreeLessons.clear();
      (response['data'] as List).forEach((value) {aboutAcademyFreeLessons.addAll([value]); }) ;

      changeViewState(AppViewState.idle);
      aboutAcademyFreeLessonsState.value = AppViewState.idle;
    } catch (e) {
      // showSnackBar(context!, e.toString());
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
      aboutAcademyFreeLessonsState.value = AppViewState.error;

    }
  }

}

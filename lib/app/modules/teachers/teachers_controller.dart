import 'package:al_mariey/app/core/data/models/teacher.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';

class TeachersController extends BaseController {
  List<Teacher> teachersList = [];
  List<Teacher> filteredTeachers = [];
  TeachersController() {
    getAllTeachers();
  }

  Future getAllTeachers() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
          "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/academyApi/json.php?function=teachers");
      if (response['data'] != null) {
        teachersList = (response['data']['teachers'] as List)
            .map((e) {
              return Teacher.fromJson(e);
            })
            .cast<Teacher>()
            .toList();
        filteredTeachers = teachersList;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      changeViewState(AppViewState.idle);
    }
  }

  filter(String str) {
    filteredTeachers = teachersList
        .where((element) =>
            (element.firstname + element.lastname).contains(str) ||
            element.job.contains(str))
        .toList();
  }
}

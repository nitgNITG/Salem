// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../utils/routing_utils.dart';
import '../../widgets/messages.dart';
import '../home/home.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final studentName_1 = TextEditingController(text: "");

  final studentName_4 = TextEditingController(text: "");
  final studentEmail = TextEditingController(text: "");
  final studentPhoneNumber_1 = TextEditingController(text: "");
  final studentPassword = TextEditingController(text: "");
  final confirmStudentPassword = TextEditingController(text: "");
  ///  view variables
  final ValueNotifier<AppViewState> viewState =
      ValueNotifier(AppViewState.idle);

  register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        changeViewState(AppViewState.busy);
        final url = CallApi.buildRegisterUrlParams(
          fname: studentName_1.text.toString(),
          lname: studentName_4.text.toString(),
          email: studentEmail.text.toString(),
          password: studentPassword.text.toString(),
          phone1: studentPhoneNumber_1.text.toString(),
        ).toString();
        print(url);
        final response = await CallApi.getRequest(url.toString());
        if (response["status"] == "success") {
          SharedPreferencesService.instance
              .setBool(SharedPreferencesKeys.userTypeIsGust, false);
          await saveToSharedPref(response["data"]);

          await Future.delayed(const Duration(milliseconds: 200));
          Navigator.of(context).pushAndRemoveUntil(
            routeToPage(HomeMainParentPage()),
            (route) => false,
          );
        } else {
          showSnackBar(context, response["error"]);
        }
      } catch (e) {
        debugPrint(e.toString());
        showSnackBar(context, e.toString());
      } finally {
        changeViewState(AppViewState.idle);
      }
    }
  }

  void changeViewState(AppViewState state) {
    viewState.value = state;
  }
}

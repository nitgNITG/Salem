import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/logged_user.dart';
import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../widgets/messages.dart';

class BaseProfileController extends BaseController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final thirdNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phone2Controller = TextEditingController();
  final sientificDegreeController = TextEditingController(text: "1");
  final jobController = TextEditingController();
  final password = TextEditingController();
  final newPassword = TextEditingController();
  final confirmNewPassword = TextEditingController();
  final cityController = TextEditingController(text: "1");

  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  LoggedUser? user;
  ValueNotifier<LoggedUser>? listener;
  Future StudentDetail() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "https://salem-mar3y.com/salem_apis/academyApi/json.php?function=get_user_data&token=${getLoggedUser().token}",
      );
      print(response);
      if (response['status'] != 'fail') {
        user = getLoggedUser();
        user!.phone=response['data']['phone1'];
        user!.image=response['data']['img'];
        user!.email=response['data']['email'];
        user!.firstName=response['data']['firstname'];
        user!.lastName=response['data']['lastname'];
        if(listener==null) listener=ValueNotifier<LoggedUser>(user!);
        listener!.value=user!;
        listener!.notifyListeners();
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
    }
  }

  Future<LoggedUser> Student() async {
    try {
    changeViewState(AppViewState.busy);
    final response = await CallApi.getRequest(
      "https://salem-mar3y.com/salem_apis/academyApi/json.php?function=get_user_data&token=${getLoggedUser().token}",
    );
    print(response);
    if (response['status'] != 'fail') {
      user = getLoggedUser();
      user!.phone = response['data']['phone1'];
      user!.image = response['data']['img'];
      user!.email = response['data']['email'];
      user!.firstName = response['data']['firstname'];
      user!.lastName = response['data']['lastname'];
      changeViewState(AppViewState.idle);
      return user!;
    }
    } catch (e) {
      changeViewState(AppViewState.error);
     return getLoggedUser();
    }
    return getLoggedUser();
  }
  updateUserData(context) async {
    if (formKey.currentState!.validate()) {
      try {
        changeViewState(AppViewState.busy);

        final response = await CallApi.getRequest(
          "https://salem-mar3y.com/salem_apis/signleteacher/apis.php?function=edit_user&token=${getLoggedUser().token}&fname=${firstNameController.text}"
              "&lname=${lastNameController.text}&email=${emailController.text}&phone1=${phoneController.text.toString()}");
print(response);
        if (response['status'] != 'fail') {
          Navigator.of(context).pop();     if(Navigator.canPop(context))  Navigator.of(context).pop();
          saveUser();
          Future.delayed(Duration(milliseconds: 100));
          showSnackBar(context, "تم تحديث البيانات بنجاح", color: HexColor('#008170'));
          await StudentDetail();
          changeViewState(AppViewState.idle);
        } else {
          showSnackBar(context, getL10(context).tryAgain);
        }
      } catch (e) {
        changeViewState(AppViewState.error);
        print(e.toString());
      }
    }
  }

  updateUserPassword(context) async {

      try {
        changeViewState(AppViewState.busy);

        final response = await CallApi.getRequest(
          "https://salem-mar3y.com/salem_apis/signleteacher/apis.php?function=change_pas&token=${getLoggedUser().token}"
              "&oldpassword=${password.text}&newpassword=${newPassword.text}");
        print(response);
        if (response['status'] != 'fail') {
          Navigator.of(context).pop();
          Future.delayed(Duration(milliseconds: 100));
          showSnackBar(context, " تم تغيير كلمة المرور بنجاح", color: HexColor('#008170'));
          changeViewState(AppViewState.idle);
        } else {
          showSnackBar(context, getL10(context).tryAgain2);
        }
      } catch (e) {
        changeViewState(AppViewState.error);
        print(e.toString());
      }
      clear();
  }

  void clear(){
  password.clear();
  newPassword.clear();
  confirmNewPassword.clear();
  }

  void setDataForBottomSheet() {
    firstNameController.text = getLoggedUser().firstName;

    lastNameController.text = getLoggedUser().lastName;

    phoneController.text = getLoggedUser().phone;

    emailController.text = getLoggedUser().email;
  }

  saveUser() async {
    final user = LoggedUser(
      id: getLoggedUser().id,
      firstName: firstNameController.text.toString(),
      lastName: lastNameController.text.toString(),
      image: getLoggedUser().image,
      token: getLoggedUser().token,
      email: emailController.text.toString(),
      role: getLoggedUser().role,
      phone: phoneController.text.toString(),
      coursesCount: getLoggedUser().coursesCount,
      isAdmin: getLoggedUser().isAdmin,
    );

    await SharedPreferencesService.instance
        .setString(SharedPreferencesKeys.loggedUser, user.toString());
  }
}

import 'package:al_mariey/app/core/data/models/teacher.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/my_course.dart';
import '../base/profile_controller.dart';

class TeacherProfileController extends BaseProfileController {
  TeacherDetails? details;

  int students_count = 0;
  List certificates = [];
  List workShops = [];
  List obtainedCerts = [];
  List experiences = [];
  List<MyCourse> courses = [];
/* 
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController(); */

// ""
  String joinListAsString(List list, String key) {
    return list.map((e) => e[key]).cast<String>().toList().join("-");
  }

  Future getTeacherDetails(String id) async {
    try {
      changeViewState(AppViewState.busy);

      final response = await CallApi.getRequest(
        "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/academyApi/json.php?function=teacher_data&id=$id",
      );

      if (response['status'] != 'fail') {
        details = TeacherDetails.fromJson(
            (response['data']['teacher'] as List).first);
        experiences = (response['data']['experiences'] as List);

        workShops = (response['data']['workshops'] as List);
        // item course

        obtainedCerts = (response['data']['obtained'] as List);
//item   certificate

        certificates = (response['data']['certificates'] as List);

        students_count = response['data']['students_count'];
        courses = (response['data']['courses'] as List)
            .map((e) => MyCourse.fromJson(e))
            .cast<MyCourse>()
            .toList();

        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
    }
  }

  Future<bool> addTecherProperty(String key, String value) async {
    try {
      changeViewState(AppViewState.busy);
    await CallApi.getRequest(
        "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?function=edit_teacher_profile&token=${getLoggedUser().token}&$key=$value",
      );

      getTeacherDetails(getLoggedUser().id.toString());
      // changeViewState(AppViewState.idle);
      return true;
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
      return false;
    }
  }

  Future<bool> removeTecherProperty(String key, String value) async {
    try {
      changeViewState(AppViewState.busy);
      await CallApi.getRequest(
        "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?function=delete_teacher_data&token=${getLoggedUser().token}&$key=$value",
      );
      getTeacherDetails(getLoggedUser().id.toString());

      return true;
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
      return false;
    }
  }
/* 
  displayBottomSheet(BuildContext context) {
    setDataForBottomSheet();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.withOpacity(0),
      isScrollControlled: true,
      constraints: BoxConstraints.tight(
        Size(getScreenWidth(context), getScreenHeight(context) * .8),
      ),
      builder: (context) => buildBottomSheet(context),
    );
  }

  Stack buildBottomSheet(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: getScreenHeight(context),
          width: getScreenWidth(context),
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.only(top: 50, left: 8, right: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Divider(
                  color: kPrimaryColor,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                TextFormFieldWidget(
                  title: "الاسم الاول",
                  fillColor: Colors.grey.shade400,
                  controller: firstNameController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                TextFormFieldWidget(
                  title: "الاسم الاخير",
                  fillColor: Colors.grey.shade400,
                  controller: lastNameController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                TextFormFieldWidget(
                  title: "نبذه ",
                  fillColor: Colors.grey.shade400,
                  controller: descriptionController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                TextFormFieldWidget(
                  title: "البريد الالكتروني",
                  fillColor: Colors.grey.shade400,
                  controller: emailController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                TextFormFieldWidget(
                  title: "العنوان",
                  fillColor: Colors.grey.shade400,
                  controller: addressController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                TextFormFieldWidget(
                  title: "رقم الهاتف",
                  fillColor: Colors.grey.shade400,
                  controller: phoneController,
                  titleColor: getThemeData(context).colorScheme.onBackground,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        updateUserData(context);
                      },
                      child: const Text('حفظ التغييرات'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 125,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryColor.withOpacity(0.6)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('الغاء'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -10,
          width: getScreenWidth(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 120,
                child: Stack(
                  children: [
                    Image.network(getLoggedUser().image),
                  ],
                ),

                /* decoration: BoxDecoration(
                                                  color: getRandomQuietColor(),
                                                borderRadius:
                                                      BorderRadius.circular(8)),*/
              ),
            ],
          ),
        )
      ],
    );
  }

  updateUserData(context) async {
    try {
      changeViewState(AppViewState.busy);
      final firstName = firstNameController.text.toString();
      final lastName = lastNameController.text.toString();
      final email = emailController.text.toString();
      final address = addressController.text.toString();
      final phone = phoneController.text.toString();
      final nationalId = getLoggedUser().username;
      final descrip = descriptionController.text.toString();
      final response = await CallApi.getRequest(
        "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/signleteacher/apis.php?function=edit_user&token=${getLoggedUser().token}&phone1=$phone&address=$address&fname=$firstName&lname=$lastName&email=$email&nationalid=$nationalId&description=$descrip",
      );

      if (response['status'] != 'fail') {
        Navigator.of(context).pop();

        await SharedPreferencesService.instance.setString(
            SharedPreferencesKeys.loggedUser,
            LoggedUser(
              id: getLoggedUser().id,
              username: getLoggedUser().username,
              firstName: firstNameController.text.toString(),
              secondName: "",
              thirdName: "",
              lastName: lastNameController.text.toString(),
              image: getLoggedUser().image,
              token: getLoggedUser().token,
              email: email,
              role: getLoggedUser().role,
              year: getLoggedUser().year,
              phone: phoneController.text.toString(),
              phone2: getLoggedUser().phone2,
              city: address,
              school: getLoggedUser().school,
              center: getLoggedUser().center,
              address: address,
              coursesCount: getLoggedUser().coursesCount,
              gender: getLoggedUser().gender,
              job: getLoggedUser().job,
              scientificDegree: getLoggedUser().scientificDegree,
              isAdmin: getLoggedUser().isAdmin,
            ).toString());
        Future.delayed(const Duration(milliseconds: 100));

        showSnackBar(context, "تم تحديث البيانات", color: kPrimaryColor);

        changeViewState(AppViewState.idle);
      } else {
        showSnackBar(context, "حدث خطأ لم يتم التحديث");
      }
    } catch (e) {
      changeViewState(AppViewState.error);
      print(e.toString());
    }
  }

  void setDataForBottomSheet() {
    firstNameController.text = getLoggedUser().firstName;
    lastNameController.text = getLoggedUser().lastName;
    emailController.text = getLoggedUser().email;
    phoneController.text = getLoggedUser().phone;
    descriptionController.text = details!.description ?? "";
  }
 */
}

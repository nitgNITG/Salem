import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/login/login_controller.dart';
import 'package:al_mariey/app/modules/privacy/privacy.dart';
import 'package:al_mariey/app/modules/register/create_account_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/utils/validators.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/form_fields.dart';
import '../../widgets/logos.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final RegisterController registerController;

  @override
  void initState() {
    // TODO: implement initState
    registerController = RegisterController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RegisterForm(
      controller2: LoginController(),
      controller: registerController,
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key, required this.controller, required this.controller2});
   final LoginController controller2;
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    controller2.getAllRightReserverved();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        padding: EdgeInsets.only(top: 50),
        height: getScreenHeight(context),
        width: getScreenWidth(context),
      color: HexColor('#45474B'),
        child: Stack(
          children: [
       SizedBox(
                height: 110,
                child: const VocationalAcademyHorizontalRegister(show: false)),
       Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: Form(
                    key: controller.formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getHeightSpace(10),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: getScreenSize(context).width * 0.01,
                              ),
                              child: Text(
                               getL10(context).createAccount,
                                textAlign: TextAlign.center,
                                style: getThemeData(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                  color:
                                  getThemeData(context).colorScheme.onPrimary,
                                  fontSize: 16,
                                  fontFamily: 'Medium',
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              )),
                          getHeightSpace(getScreenHeight(context) * 0.03),
                          SizedBox(
                            // width: getScreenWidth(context) * 0.4,
                            child: TextFormFieldWidget(
                              heightOfBoty: 35,
                              maxLength: 20,
                              formatters:  [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ا-ي]')),
                                FilteringTextInputFormatter.deny(r' '),
                                FilteringTextInputFormatter.deny(r'-')
                              ],
                              hint: getL10(context).firstName,
                              title: getL10(context).firstName,
                              controller: controller.studentName_1,
                              validatetor: Validators(context).validateName,
                            ),
                          ),                                                     /// الاسم الاول
                          SizedBox(
                            // width: getScreenWidth(context) * 0.4,
                            child: TextFormFieldWidget(
                              heightOfBoty: 35,
                              maxLength: 20,
                              hint: getL10(context).lastName,
                              formatters:  [
                                FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ا-ي]')),
                                FilteringTextInputFormatter.deny(r'-')
                              ],
                              title: getL10(context).lastName,
                              controller: controller.studentName_4,
                              validatetor: Validators(context).validateLName,
                            ),
                          ),                                                     /// الاسم الثاني
                          /// contact info
                          TextFormFieldWidget(
                            heightOfBoty: 35,
                            maxLength: 30,
                            title: getL10(context).email,
                            formatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[a-z@.]')),
                              FilteringTextInputFormatter.deny(RegExp(r'[A-Z ا-ي]')),
                              FilteringTextInputFormatter.deny(RegExp(r' '))
                            ],
                            controller: controller.studentEmail,
                            textInputType: TextInputType.emailAddress,
                            validatetor: Validators(context).validateEmail,
                          ),                                          /// حقل الايميل
                          TextFormFieldWidget(
                            heightOfBoty: 35,
                            maxLength: 14,
                            title: getL10(context).phone,
                            hint: '01xxxxxxxx',
                            formatters:  [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              FilteringTextInputFormatter.deny(RegExp(r' ')),
                              FilteringTextInputFormatter.deny(RegExp(r'-'))
                            ],
                            controller: controller.studentPhoneNumber_1,
                            textInputType: TextInputType.phone,
                            // suffix: Text('966+'),
                            validatetor: Validators(context).validatePhone,
                          ),                                          /// حقل التليفون
                          PasswordFormField(
                            bodyHeight: 40,
                            maxLength: 20,
                            title: getL10(context).password,
                            controller: controller.studentPassword,
                            validatetor: (value) {
                              if(value!=controller.confirmStudentPassword.text)
                                return getL10(context).pleaseEnterValidPaswordLengthMustBeMoreThan2;
                              if ((value?.isNotEmpty ?? false) &&
                                  value!.length > 5) {
                                return null;
                              }
                              return getL10(context)
                                  .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                            },
                          ),
                          PasswordFormField(
                            bodyHeight: 40,
                            maxLength: 20,
                            title: getL10(context).confirm,
                            controller: controller.confirmStudentPassword,
                            validatetor: (value) {
                              if(value!=controller.studentPassword.text)
                                return getL10(context).pleaseEnterValidPaswordLengthMustBeMoreThan2;
                              if ((value?.isNotEmpty ?? false) &&
                                  value!.length > 5) {
                                return null;
                              }
                              return getL10(context)
                                  .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                            },
                          ),  /// حقل الباسوورد
                          getHeightSpace(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getNormalText(
                                getL10(context).click,
                                context,
                                color: kOnPrimary,
                                weight: FontWeight.bold,
                                size: 12,
                                family:  'Medium',
                              ),
                              getWidthSpace(5),
                              getNormalText(
                                  getL10(context).privacy,
                                  context,
                                  weight: FontWeight.bold,
                                  color: HexColor('#F4CE14'),
                                  size: 12,
                                  family:  'Medium',
                                  underline: true
                              ).onTap(() {
                                Navigator.of(context)
                                    .push(routeToPage( PrivacyScreen()));
                              }),
                            ],
                          ),
                          getHeightSpace(10),
                          Center(
                            child: SizedBox(
                                width: getScreenWidth(context) * 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset:Offset(0.1,0.1),
                                            blurRadius: 0.1,
                                            spreadRadius: 0.1
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                      color: HexColor('#F4CE14')
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      controller.register(context);
                                    },
                                    child: Text(
                                      getL10(context).createNewStudentAccount,
                                      style: TextStyle(color: HexColor('#45474B'),fontSize: 16,fontFamily: 'Medium'),
                                    ),
                                  ),
                                )
                            ),
                          ),                                                       /// زرار ال log in
                          SizedBox(height: 10),                                                                    ///
                          Center(
                            child: SizedBox(
                                width: getScreenWidth(context) * 0.9,
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset:Offset(0.1,0.1),
                                          blurRadius: 0.1,
                                          spreadRadius: 0.1
                                      ),],
                                    borderRadius: BorderRadius.circular(5),
                                    color: HexColor('#F4CE14'),
                                  ),
                                  child: TextButton(
                                    onPressed:  () {
                                      LoginController().loginAsGuest(context);
                                    },
                                    child:  Text(
                                      getL10(context).loginAsGuest,
                                      style: TextStyle(color: HexColor('#45474B'),fontSize: 16,fontFamily: 'Medium'),
                                    ),
                                  ),
                                )
                            ),
                          ),                                                       /// زرار ال sign up
                          getHeightSpace(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              getNormalText(
                                getL10(context).alreadyHaveAnAccount,
                                context,
                                family:  'Medium',
                                color: kOnPrimary,
                                weight: FontWeight.bold,
                                size: 14,
                              ),
                              getWidthSpace(5),
                              getNormalText(
                                  getL10(context).login,
                                  context,
                                  family:  'Medium',
                                  weight: FontWeight.bold,
                                  color: HexColor('#F4CE14'),
                                  size: 14,
                                  underline: true
                              ).onTap(() {
                                Navigator.of(context).pop();
                              }),
                            ],
                          ), SizedBox(
    height: getScreenHeight(context) * 0.171,
    child: ValueListenableBuilder(
    valueListenable: controller2.allRightsText,
    builder: (context, allRights, child) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    const Spacer(),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    getNormalText(allRights, context,
    color:Colors.white, size: 10),
    getNormalText(
    " ${controller2.allRightsYear}",
    context,
      family: 'Medium',
    color:Colors.white,
    size: 10,
    ),
    ],
    ),
      SizedBox(
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getNormalText(
                controller2.allRightsCompanyName+' ' +controller2.allRightsCompanyNameEnglish, context,
                color:Colors.white, size: 10).onTap(() {
              launchURL(controller2.allRightsLink);
            })
          ],
        ),
      ),]);}))
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     getNormalText(
                          //       "Are you a teacher?",
                          //       context,
                          //       color: kPrimaryColor,
                          //       weight: FontWeight.normal,
                          //       size: 16,
                          //     ),
                          //     getWidthSpace(5),
                          //     getNormalText(
                          //       "Join our team!",
                          //       context,
                          //       weight: FontWeight.bold,
                          //       color: kPrimaryColor,
                          //       size: 18,
                          //     ).onTap(() {
                          //       contactUsWhatsapp();
                          //     }),
                          //   ],
                          // ),
                          /// الصف بتاع هل انت مدرس ؟ سجل معنا

                        ],
                      ),
                    ),
                  ),
                )
          ],
        ),
      ),
    );
  }
  void launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class CustomRadioSelect extends StatefulWidget {
  const CustomRadioSelect({
    super.key,
    required this.list,
    required this.controller,
  });

  final List<Map<String, String>> list;
  final TextEditingController controller;

  @override
  State<CustomRadioSelect> createState() {
    return _CustomRadioSelectColumnState();
  }
}

class _CustomRadioSelectColumnState extends State<CustomRadioSelect> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: widget.list
            .map(
              (e) => SizedBox(
            // color: getRandomQuietColor().withOpacity(0.5),

            /*     width: (getScreenWidth(context) * (1 - widget.titleWidth)) /
            widget.list.length,*/
            height: 50,
            child: Row(
              children: [
                getWidthSpace(10),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: widget.controller.text.toString() ==
                        e["index"].toString()
                        ? kPrimaryColor
                        : kOnPrimary,
                    border: Border.all(color: kOnPrimary),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                getWidthSpace(10),
                getNormalText(
                  e["name"].toString(),
                  context,
                  color: kOnPrimary,
                  weight: FontWeight.bold,
                ),
                getWidthSpace(10),
              ],
            ),
          ).onTap(() {
            setState(() {
              widget.controller.text = e["index"].toString();
            });
          }),
        )
            .toList(),
      ),
    );
  }
}

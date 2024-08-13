import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants_and_enums/enums.dart';
import '../../../core/data/shared_preferences/helper_funcs.dart';
import '../../../core/themes/colors.dart';
import '../../../utils/helper_funcs.dart';
import '../../../utils/routing_utils.dart';
import '../../../widgets/form_fields.dart';
import '../../../widgets/texts.dart';
import '../../register/create_account.dart';
import '../login_controller.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    super.key,
    required this.controller,
  });

  final LoginController controller;
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
   color: HexColor('#45474B')
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // color: getRandomQuietColor(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Center(
                  //   child: Text(
                  //     "Welcome !",
                  //     textAlign: TextAlign.center,
                  //     style: getThemeData(context)
                  //         .textTheme
                  //         .displayLarge!
                  //         .copyWith(
                  //       color:
                  //       getThemeData(context).colorScheme.onPrimary,
                  //       fontSize: 26,
                  //       fontWeight: FontWeight.w900,
                  //       height: 1.5,
                  //     ),
                  //   ),
                  // ),                                                            /// كلمه welcome
                  // getHeightSpace(3),
                  // Center(
                  //   child: Text(
                  //     "STEP ACADEMY",
                  //     textAlign: TextAlign.center,
                  //     style: getThemeData(context)
                  //         .textTheme
                  //         .displayLarge!
                  //         .copyWith(
                  //       color:
                  //       getThemeData(context).colorScheme.onPrimary,
                  //       fontSize: 26,
                  //       fontWeight: FontWeight.w900,
                  //       height: 1,
                  //     ),
                  //   ),
                  // ),                                                             /// كلمه step academy
                  Divider(height: 10,color: Colors.transparent),
              Padding(
              padding: EdgeInsets.symmetric(
              horizontal: getScreenSize(context).width * 0.05,
            ),
            child: Text(
                      "تسجيل الدخول",
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
                  getHeightSpace(getScreenHeight(context) * 0.02),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getScreenSize(context).width * 0.05,
                    ),
                    child: TextFormFieldWidget(
                      title: getL10(context).email,
                      controller: controller.emailController,
                      titleColor: kOnPrimary,
                      formatters:  [
                        FilteringTextInputFormatter.deny(r'[ ]'),
                      ],
                      heightOfBoty: 35,
                      validatetor: Validators(context).validateEmail,
                      showCounter: false,
                      // maxLength: 14,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),                                                              /// زر ال Email
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getScreenSize(context).width * 0.05,
                    ),
                    child: PasswordFormField(
                      maxLength: 20,
                      title: getL10(context).password,
                      controller: controller.passwordController,
                      validatetor: (value){
                      if ((value?.isNotEmpty ?? false) &&
                          value!.length > 5) {
                        return null;
                      }
                      return getL10(context)
                          .pleaseEnterValidPaswordLengthMustBeMoreThan4;},
                      titleColor: kOnPrimary,
                      bodyHeight: 40,
                    ),
                  ),                                                              /// زر ال password
                  /// dont have account yet
                  getHeightSpace(getScreenHeight(context) * 0.01),
                  // const Spacer(),
                  LoginButton(controller: controller),
                  getHeightSpace(getScreenHeight(context) * 0.01),/// تسجيل الدخول
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: getScreenSize(context).width * 0.05,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(

                        backgroundColor: HexColor('#F4CE14'),
                        maximumSize: Size(
                          getScreenSize(context).width - 30, 100,
                        ),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(
                          getScreenSize(context).width - 30, 50,
                        ),
                      ),
                      onPressed: () {
                        controller.loginAsGuest(context);
                      },
                      child: Text(
                        getL10(context).loginAsGuest,
                        style:  TextStyle(
                          fontSize: 16,
                          fontFamily: 'Medium',
                          color: HexColor('#45474B'),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),                                /// تسجيل الدخول ك guest
                  ),                                                 /// تسجيل الدخول ك guest

                  /// Are you teacher  join us
                  getHeightSpace(3),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     getNormalText(
                  //       "Are you a teacher?",
                  //       context,
                  //       color: kOnPrimary,
                  //       weight: FontWeight.bold,
                  //       size: 16,
                  //     ),
                  //     getWidthSpace(5),
                  //     getNormalText(
                  //       "Join our team!",
                  //       context,
                  //       weight: FontWeight.bold,
                  //       color: Colors.black,
                  //       size: 16,
                  //     ).onTap(() {
                  //       contactUsWhatsapp();
                  //     }),
                  //   ],
                  // ),                                                    ///كلمه هل انت مدرس انضم معنا
                  //const Spacer(),
          getHeightSpace(5),

          /// dont have an account yet text
          ///
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getNormalText(
                getL10(context).dontHaveaccountyet,
                context,
                family: 'Medium',
                color: kOnPrimary,
                weight: FontWeight.bold,
                size: 14,
              ),
              getWidthSpace(5),
              getNormalText(
                  getL10(context).createAccount,
                  context,
                  family: 'Medium',
                  weight: FontWeight.bold,
                  color: HexColor('#F4CE14'),
                  size: 14,
                  underline: true
              ).onTap(() {
                Navigator.of(context)
                    .push(routeToPage(const RegisterPage()));
              }),
            ],
          ),                                                  /// contact us كلمه
                  // Center(
                  //   child: Container(
                  //     padding: const EdgeInsets.all(1),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(5)),
                  //     height: getScreenHeight(context) * 0.05,
                  //     child:
                  //     SvgPicture.asset("assets/images/whatsapp_ic.svg"),
                  //   ),
                  // ).onTap(() {                                           /// فانكشن الواتساب
                  //   contactUsWhatsapp();
                  // }),
                  /// allrights reserved text                                  /// كلمه حقوق الطبع والنشر محفوظه
                  ///
                  // const Spacer()

                ],
              ),
            )
          ],
        ),                                                    /// من اول كلمه welcome  لحد حقوق الطبع والنشر
      )
    );
  }


}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (context, state, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getScreenSize(context).width * 0.05,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor('#F4CE14'),
                maximumSize: Size(
                  getScreenSize(context).width,
                  50,
                ),
                minimumSize: Size(
                  getScreenSize(context).width,
                  50,
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                controller.login();
              },
              child: state == AppViewState.busy
                  ? const SizedBox(
                  height: 30,
                  child: CircularProgressIndicator(
                    color: kOnPrimary,
                  ))
                  : getNormalText(getL10(context).login, context,
                  color: HexColor('#45474B'), weight: FontWeight.bold, size: 16,family: 'Medium'),      /// الخط بتاع الكلام اللي في زرار ال login
            ),
          );
        });
  }
}

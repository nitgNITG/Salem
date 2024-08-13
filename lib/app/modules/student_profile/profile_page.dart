import 'dart:convert';
import 'dart:ui';

import 'package:al_mariey/app/core/constants_and_enums/static_data.dart';
import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/base/profile_controller.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_page.dart';
import 'package:al_mariey/app/modules/forget_password/forget_password_page.dart';
import 'package:al_mariey/app/modules/home/home.dart';
import 'package:al_mariey/app/modules/home_page/helper_widgets/course_item.dart';
import 'package:al_mariey/app/modules/student_profile/profile_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/image_picker.dart';
import 'package:al_mariey/app/widgets/messages.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:page_animation_transition/animations/bottom_to_top_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../global_used_widgets/widget_methods.dart';
import '../login/login_page.dart';
import 'sub_widgets/edit_profile_bottom_sheet.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late final BaseProfileController controller;

  LoggedUser getLoggedUser() {
    final jsonString = SharedPreferencesService.instance.getString(SharedPreferencesKeys.loggedUser);
    return LoggedUser.fromString(jsonString!);
  }
  LoggedUser? loggedUser;

  @override
  void initState() {
    controller = BaseProfileController();
    controller.user=controller.getLoggedUser();
      controller.listener=ValueNotifier<LoggedUser>(controller.user!);
    grt();
      setState(() {});
    super.initState();
  }

  grt() async {
   await controller.StudentDetail();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenSize(context).height - (MediaQuery.of(context).padding.bottom),
      width: getScreenSize(context).width,
      child: BaseView<BaseProfileController>(
        injectedObject: controller,
        child: Scaffold(
          body: Container(
            height: getScreenSize(context).height - (MediaQuery.of(context).padding.bottom),
            width: getScreenSize(context).width,
            color: getThemeData(context).colorScheme.background,
            child: Builder(builder: (context) {
              return  Column(
                      children: [
                        NormalAppBar(
                          title: getL10(context).profile),
                        Expanded(
                          child:ValueListenableBuilder(valueListenable:controller.listener! ,
                            builder: (BuildContext context, LoggedUser value, Widget? child) {
                            return  Container(
                              child: RefreshIndicator(
                                  onRefresh: () async {
                                    setState(() {});
                                  },
                                  child:Stack(children: [
                                    Container(width:getScreenWidth(context),height: getScreenHeight(context)*0.2,color: HexColor('#45474B'),
                                    ),
                                    Padding(padding: EdgeInsets.only(top:getScreenHeight(context)* 0.001,right:getScreenWidth(context)* 0.325,
                                    ) ,child:  ImagePickerWidget(
                                      edit: true,
                                      loggedUser: value,
                                    )),
                                    Padding(padding:EdgeInsets.only(top:getScreenHeight(context)* 0.3,left: 10,right: 20),child:
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          getRowItemProfile(
                                            context,
                                            getL10(context).name,
                                            value.firstName.toString()+' '+value.lastName,
                                          ),
                                          divider()
                                          , getRowItemProfile(
                                            context,
                                            getL10(context).email,
                                            value.email,
                                          ),
                                          divider(),
                                         Padding(padding: EdgeInsets.only(right: getScreenWidth(context)>getScreenHeight(context)?
                                         getScreenWidth(context)*0.01:getScreenHeight(context)*0.01),child:  getRowItemProfile(
                                            context,
                                            getL10(context).phone,
                                            value.phone,
                                          )),
                                          divider(),
                                          getHeightSpace( getScreenHeight(context)*0.1),
                                          button(
                                            Row(mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ImageIcon(AssetImage('assets/images/profile2.png'),size:getScreenWidth(context)*0.05,color: HexColor('#45474B') ),
                                              getNormalText(' '+getL10(context).update, context,family: 'Bold',size: 12,color:HexColor('#45474B') )

                                              ],
                                            ),(){  Navigator.push(context, PageAnimationTransition(
                                              page:EditProfileBottomSheet(controller: controller,user: value)  ,  pageAnimationType: BottomToTopTransition()));},
                                          ), getHeightSpace(10),
                                          button(
                                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [ImageIcon(AssetImage('assets/images/reset.png'),size:getScreenWidth(context)*0.1,color: HexColor('#45474B') ),
                                                getNormalText(getL10(context).changePassword, context,family: 'Bold',size: 12,color:HexColor('#45474B') ) ]),
                                                  (){Navigator.push(context, PageAnimationTransition(
                                                      page:ForgetPasswordPage(controller: controller, user: value),
                                                      pageAnimationType: BottomToTopTransition()));})
                                        ,
                                          getHeightSpace(10),
                                          button(
                                              Row(mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Icon(Icons.delete_outline,size:getScreenWidth(context)*0.07,color: HexColor('#45474B') ),
                                                    getNormalText(getL10(context).delete2, context,family: 'Bold',size: 12,color:HexColor('#45474B') ) ]),
                                                  (){ Exit(context); }),
                                          getHeightSpace( getScreenHeight(context)*0.1),
                                        ],
                                      ),
                                    ))
                                  ])
                              ),
                            );
                            },)

                        ),

                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Future<bool> _deleteUserAccount(BuildContext context) async {
    try {
      final response = await http.delete(Uri.parse("https://salem-mar3y.com/salem_apis/academyApi/json.php?function=delete_user_account&token=${getLoggedUser().token}"));
      if (response.statusCode == 200) {
        if(mounted)  showSnackBar(context, getL10(context).deleted,
            color: HexColor('#008170'));
        return true;
      } else {
        print('Error deleting account: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error $e');
      return false;
    }
  }

  Widget button(Widget child,Function() press){
   return Center(child:ElevatedButton(style: ElevatedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
       alignment: Alignment.center
       ,backgroundColor:HexColor('#F4CE14'),maximumSize: Size(getScreenWidth(context)*0.5,
       getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.06:getScreenWidth(context)*0.05),minimumSize:Size(getScreenWidth(context)*0.5,
       getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.06:getScreenWidth(context)*0.05)  ), onPressed: press,
        child:child));
  }

  Widget divider()=>Center(child:Container(height: 1,width: getScreenWidth(context)*0.8,color: HexColor('#F4CE14')) );

  Widget getRowItemProfile(BuildContext context, title, value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        getHeightSpace(5),
        getNormalText(title , context, weight: FontWeight.w700,size: 14,color: Colors.black,family: 'Medium'),
        getHeightSpace(1),
      if(value.toString().isNotEmpty) Padding(padding: EdgeInsets.only(right: getScreenWidth(context)*0.1),
       child:  getNormalText(  value, context, weight: FontWeight.w400,size: 12,color: Colors.black,family: 'Medium')),
        getHeightSpace(10),
      ],
    );
  }

  Exit(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 1.5,
        ),
        child: AlertDialog(
          backgroundColor: HexColor('#45474B'),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)),
          titlePadding: const EdgeInsets.symmetric(

          ),
          title: Align(alignment: Alignment.centerRight,child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.close,color: Colors.white)
          )), actionsAlignment: MainAxisAlignment.start,
          content: SizedBox(
            height:getScreenWidth(context)<getScreenHeight(context)? getScreenHeight(context) * 0.15:getScreenWidth(context)*0.15,
            width: getScreenWidth(context)*0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getNormalText(
                  getL10(context).delete_user,
                  context,
                  family: 'Bold',
                  size:   getScreenWidth(context)<getScreenHeight(context)?
                  getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,
                  color: Colors.white,
                ),
                getHeightSpace(getScreenHeight(context)*0.05),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height:getScreenWidth(context)<getScreenHeight(context)? getScreenHeight(context) * 0.06:getScreenWidth(context)*0.06,
                      width: getScreenWidth(context)*0.3,
                      color: HexColor('#F4CE14'),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          getL10(context).cancel,
                          style: TextStyle(color: Colors.white,fontSize:
                          getScreenWidth(context)<getScreenHeight(context)?
                          getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                    Container(
                      height:getScreenWidth(context)<getScreenHeight(context)? getScreenHeight(context) * 0.06:getScreenWidth(context)*0.06,
                      width: getScreenWidth(context)*0.3,
                      color: HexColor('#008170'),
                      child: TextButton(
                        onPressed: () async {
                          await _deleteUserAccount(context);
                          Navigator.of(context).pushAndRemoveUntil(
                            routeToPage(
                              const LoginPage(),
                            ),
                                (c) => false,
                          );
                        },
                        child: Text(
                          getL10(context).yes,
                          style: TextStyle(color: Colors.white,fontSize:
                          getScreenWidth(context)<getScreenHeight(context)?
                          getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,fontFamily: 'Bold'),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),                                                   /// اخر حاجه خالص هل تريد الخروج ام لا
      ),
      barrierDismissible: true,
      barrierColor:
      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
    );
  }

}
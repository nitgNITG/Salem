import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/base/profile_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/form_fields.dart';
import 'package:al_mariey/app/widgets/image_picker.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, required this.controller, required this.user});
  final BaseProfileController controller;
  final LoggedUser? user;

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  @override
  void dispose() {
    widget.controller.password.clear();
    widget.controller.newPassword.clear();
    widget.controller.confirmNewPassword.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
      height: getScreenSize(context).height - (MediaQuery.of(context).padding.bottom),
      width: getScreenSize(context).width,
      child: BaseView<BaseProfileController>(
        injectedObject: widget.controller,
        child: Scaffold(
          body: Container(
            height: getScreenSize(context).height - (MediaQuery.of(context).padding.bottom),
            width: getScreenSize(context).width,
            color: getThemeData(context).colorScheme.background,
            child: Builder(builder: (context) {
              final loggedUser = widget.controller.getLoggedUser();
              return  Column(
                children: [
                  Expanded(
                    child: Container(
                      child: RefreshIndicator(
                          onRefresh: () async {
                          },
                          child:Stack(children: [
                            Container(width:getScreenWidth(context),height: getScreenHeight(context)*0.17,color: HexColor('#45474B'),
                            ),
                      Padding(padding: EdgeInsets.only(top:getScreenHeight(context)* 0.19),child:  Container(width:getScreenWidth(context),
                        height: getScreenHeight(context),color: HexColor('#45474B'),
                            )),
                            IgnorePointer(ignoring: true,child:  Padding(padding: EdgeInsets.only(top:getScreenHeight(context)* 0.001,right:
                            getScreenWidth(context)* 0.32,
                            ) ,child:  ImagePickerWidget(
                              edit: false,
                              loggedUser: widget.user??loggedUser,
                            )
                            )),
                            Padding(padding:EdgeInsets.only(top:getScreenHeight(context)* 0.3,left: 10,right: 10),child:
                      Form(key: widget.controller.formKey,child:       SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getNormalText(getL10(context).changePassword,family: 'Medium',
                                      context,color: Colors.white,size: 18),
                                  getHeightSpace(getScreenHeight(context)*0.05),
                                  PasswordFormField(
                                    bodyHeight: 40,
                                    title: getL10(context).current,
                                    controller: widget.controller.password,
                                    maxLength: 20,
                                    validatetor: (value) {
                                      if ((value?.isNotEmpty ?? false) &&
                                          value!.length > 5) {
                                        return null;
                                      }
                                      return getL10(context)
                                          .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                                    },
                                  ),
                                  getHeightSpace(10)
                                  ,     PasswordFormField(
                              bodyHeight: 40,
                              title: getL10(context).newp,
                              controller: widget.controller.newPassword,
                                    maxLength: 20,
                              validatetor: (value) {
                                if(value!=widget.controller.newPassword.text)
                                  return getL10(context).pleaseEnterValidPaswordLengthMustBeMoreThan2;
                                if ((value?.isNotEmpty ?? false) &&
                                    value!.length > 5) {
                                  return null;
                                }
                                return getL10(context)
                                    .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                              },
                            ),
                                  getHeightSpace(10) ,
                                PasswordFormField(
                                  bodyHeight: 40,
                                  title: getL10(context).newpc,
                                  maxLength: 20,
                                  controller: widget.controller.confirmNewPassword,
                                  validatetor: (value) {
                                    if(value!=widget.controller.newPassword.text)
                                      return getL10(context).pleaseEnterValidPaswordLengthMustBeMoreThan2;
                                    if ((value?.isNotEmpty ?? false) &&
                                        value!.length > 5) {
                                      return null;
                                    }
                                    return getL10(context)
                                        .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                                  },
                                ),
                                  getHeightSpace( getScreenHeight(context)*0.02),
                                Center(child:   SizedBox(
                                      width: getScreenWidth(context) * 0.75,
                                      child: Container(
                                        alignment: Alignment.center,
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
                                          onPressed: null,
                                          child: Text(
                                            getL10(context).save,
                                            style: TextStyle(color: HexColor('#45474B'),fontSize: 16,fontFamily: 'Medium'),
                                          ),
                                        ),
                                      )
                                  )).onTap((){     if(widget.controller.formKey.currentState!.validate())
                                  widget.controller.updateUserPassword(context);}),
                                  getHeightSpace(20),
                                 Center(child:  SizedBox(
                                      width: getScreenWidth(context) * 0.75,
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
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            getL10(context).cancel,
                                            style: TextStyle(color: HexColor('#45474B'),fontSize: 16,fontFamily: 'Medium'),
                                          ),
                                        ),
                                      )
                                  ),),
                                  getHeightSpace(20)
                                ],
                              ),
                      ) ))
                          ])
                      ),
                    ),
                  ),

                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

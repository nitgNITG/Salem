import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/modules/base/profile_controller.dart';
import 'package:al_mariey/app/utils/validators.dart';
import 'package:al_mariey/app/widgets/image_picker.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../utils/helper_funcs.dart';
import '../../../widgets/form_fields.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({
    super.key,
    required this.controller,  this.user
  });

  final BaseProfileController controller;
  final LoggedUser? user;

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {


@override
  void dispose() {
  back();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    initial();
    return Scaffold(
      backgroundColor: HexColor('#45474B'),
      body:
          Stack(children: [
            Padding(padding: EdgeInsets.only(top:getScreenHeight(context)* 0.18),child:  Container(width:getScreenWidth(context),
              height: getScreenHeight(context)*0.025,color: Colors.white,
            )),
    Padding(padding: EdgeInsets.only(top:getScreenHeight(context)* 0.03,right: getScreenWidth(context)*0.32),child:    IgnorePointer(ignoring: true,child:
    ImagePickerWidget(
      edit: false,
              loggedUser: widget.user??widget.controller.user!,
            )
            )),
            Form(
                  key: widget.controller.formKey,
                  child:   Padding(padding: EdgeInsets.only(left: 10,right:10,top: getScreenHeight(context)*0.3 ),child: SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Align(alignment: Alignment.centerRight,child:getNormalText(getL10(context).editStudentData,
                          context,color: Colors.white,size:18,weight: FontWeight.bold,family: 'Medium' ),
                      ),
                      getHeightSpace(getScreenHeight(context)*0.05),
                      SizedBox(
                        // width: getScreenWidth(context) * 0.4,
                        child: TextFormFieldWidget(
                          heightOfBoty: 35,
                          hint: getL10(context).firstName,
                          maxLength: 20,
                          formatters:  [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ا-ي]')),
                            FilteringTextInputFormatter.deny(r' '),
                            FilteringTextInputFormatter.deny(r'-')
                          ],
                          title: getL10(context).firstName,
                          controller: widget.controller.firstNameController,
                          validatetor: Validators(context).validateName,
                        ),
                      ),                                                     /// الاسم الاول
                      SizedBox(
                        // width: getScreenWidth(context) * 0.4,
                        child: TextFormFieldWidget(
                          heightOfBoty: 35,
                          maxLength: 20,
                          formatters:  [
                            FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z ا-ي]')),
                            FilteringTextInputFormatter.deny(r'-')
                          ],
                          hint: getL10(context).lastName,
                          title: getL10(context).lastName,
                          controller: widget.controller.lastNameController,
                          validatetor: Validators(context).validateLName,
                        ),
                      ),                                                     /// الاسم الثاني
                      /// contact info
                      TextFormFieldWidget(
                        heightOfBoty: 35,
                        maxLength: 25,
                        enabled: false,
                        title: getL10(context).email,
                        formatters:  [
                          FilteringTextInputFormatter.allow(RegExp(r'[a-z@.]')),
                          FilteringTextInputFormatter.deny(RegExp(r'[A-Z ا-ي]')),
                          FilteringTextInputFormatter.deny(r' '),
                        ],
                        controller: widget.controller.emailController,
                        textInputType: TextInputType.emailAddress,
                        validatetor: Validators(context).validateEmail,
                      ),                                          /// حقل الايميل
                      TextFormFieldWidget(
                        heightOfBoty: 35,
                        title: getL10(context).phone,
                        maxLength: 14,
                        hint: '01xxxxxxxx',
                        formatters:  [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.deny(RegExp(r' ')),
                          FilteringTextInputFormatter.deny(RegExp(r'-'))
                        ],
                        controller: widget.controller.phoneController,
                        textInputType: TextInputType.phone,
                        validatetor: Validators(context).validatePhone,
                      ),                                      /// حقل التليفو
                      getHeightSpace(30),
                      SizedBox(
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
                                widget.controller.updateUserData(context);
                              },
                              child: Text(
                                getL10(context).save,
                                style: TextStyle(color: HexColor('#45474B'),fontSize: 16,fontFamily: 'Medium'),
                              ),
                            ),
                          )
                      ),
                      getHeightSpace(20),
                      SizedBox(
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
                      ),
                      getHeightSpace(30)  ]                  )),
                ),)
                // const Spacer(),

          ])


    );
  }

  initial(){
    if(widget.controller.firstNameController.text.isEmpty) widget.controller.firstNameController.text=widget.controller.loggedUer!.firstName;
    if(widget.controller.lastNameController.text.isEmpty) widget.controller.lastNameController.text=widget.controller.loggedUer!.lastName;
    if(widget.controller.emailController.text.isEmpty)  widget.controller.emailController.text=widget.controller.loggedUer!.email;
   if(widget.controller.phoneController.text.isEmpty) widget.controller.phoneController.text=widget.controller.loggedUer!.phone;
  }

  back(){
  widget.controller.firstNameController.clear();
   widget.controller.lastNameController.clear();
    widget.controller.emailController.clear();
 widget.controller.phoneController.clear();
  }

}

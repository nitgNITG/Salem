import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/login/login_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/logos.dart';
import 'widgets/form_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginController controller;

  @override
  void initState() {
    controller = LoginController();
    controller.getAllRightReserverved();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BaseView<LoginController>(
      injectedObject: controller,
      child: Scaffold(
        backgroundColor: HexColor('#45474B'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Divider(height: 50,color: Colors.transparent),
              SizedBox(
                height: 200,
                width: getScreenSize(context).width,
                child:  VocationalAcademyHorizontalRegister(),
              ),
              FormBody(controller: controller),
              if( getScreenWidth(context)>getScreenHeight(context))
                getHeightSpace(getScreenWidth(context)*0.05),
              SizedBox(
                  height: getScreenHeight(context) * 0.171,
                  child: ValueListenableBuilder(
                      valueListenable: controller.allRightsText,
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
                                    " ${controller.allRightsYear}",
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
                                        controller.allRightsCompanyName+' ' +controller.allRightsCompanyNameEnglish, context,
                                        color:Colors.white, size: 10).onTap(() {
                                      launchURL(controller.allRightsLink);
                                    })
                                  ],
                                ),
                              ),]);}))
            ],
          ),
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

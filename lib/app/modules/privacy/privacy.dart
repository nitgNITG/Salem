
import 'package:al_mariey/app/modules/contact_us/contact_controller.dart';
import 'package:al_mariey/app/modules/global_used_widgets/widget_methods.dart';
import 'package:al_mariey/app/modules/privacy/privacy_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});
  
final controller=PrivacyController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Column(
              children: [
                NormalAppBar(
                  title: getL10(context).privacy,
                ),
getHeightSpace(getScreenHeight(context)*0.03),
FutureBuilder(future: controller.Privacy(), builder:(_,s){
                              if(s.connectionState==ConnectionState.waiting)
                                return Padding(padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context)*0.4
                                ,vertical: getScreenHeight(context)*0.4),child: CircularProgressIndicator(color: HexColor('#F4CE14') ));
                             else if(s.connectionState==ConnectionState.done)
                                return Expanded(child:
                                Container(padding: EdgeInsets.all(10),
                                    child:SingleChildScrollView(child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                  Text(controller.contact.title,style: TextStyle(color: Colors.black,fontSize: getScreenWidth(context)*0.06,fontWeight:
                                  FontWeight.bold,fontFamily: 'Bold')),
                                  getHeightSpace(getScreenHeight(context)*0.05),
                                  Text(controller.contact.body,style: TextStyle(color: Colors.black,fontSize: getScreenWidth(context)*0.04,fontWeight:
                                  FontWeight.bold,fontFamily: 'Bold'))
                                ]))
                                ));
                              print(controller.contact);
                              return Container();
                            })
              ],
            )
    );
  }
}

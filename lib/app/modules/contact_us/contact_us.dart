import 'dart:io';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/contact_us/contact_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';


class ContactUs extends StatelessWidget {
   ContactUs({super.key});
  
final controller=ContactController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child:  Column(
              children: [
                NormalAppBar(
                  title: getL10(context).contactUs,
                ),
getHeightSpace(getScreenHeight(context)*0.03),
FutureBuilder(future: controller.ContactUs(), builder:(_,s){
                              if(s.connectionState==ConnectionState.waiting)
                                return Padding(padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context)*0.4
                                ,vertical: getScreenHeight(context)*0.4),child: CircularProgressIndicator(color: HexColor('#F4CE14') ));
                             else if(s.connectionState==ConnectionState.done)
                                return Column(children: controller.contact.map((e) =>
                                    Stack(children: [
                                      Container(alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                          height:getScreenWidth(context)>getScreenHeight(context)?
                                          getScreenWidth(context)*0.1:getScreenHeight(context)*0.1,width: getScreenWidth(context)-20,
                                          color: HexColor('#D9D9D9'),child: Row(children: [Container(color: HexColor('#45474B'),
                                              height:getScreenWidth(context)>getScreenHeight(context)?
                                              getScreenWidth(context)*0.1:getScreenHeight(context)*0.1,width: getScreenWidth(context)*0.05)
                                          ])), ListTile(
                                        contentPadding: EdgeInsets.only(top:  getScreenWidth(context)>getScreenHeight(context)?
                                        getScreenWidth(context)*0.02:getScreenHeight(context)*0.02,right: getScreenWidth(context)*0.1,
                                        left: getScreenWidth(context)*0.1,bottom: getScreenHeight(context)*0.01),
                                        leading: Image.network(e.Icon,width: getScreenWidth(context)*0.1,height:getScreenHeight(context)*0.1),
                                        title: Text(e.title.length>25?e.title.substring(0,25)+'..':e.title,style: TextStyle(fontFamily: 'Medium',
                                            color:HexColor('#45474B'),fontSize:16)),
                                        trailing: Icon(Icons.arrow_forward_ios,color: HexColor('#F4CE14')),
                                      )
                                    ]).onTap(()  { launchURL(e.Link.contains('http')?e.Link:
                                    'tel:${e.Link}'); })).toList());
                              return Container();
                            })
              ],
            )
      )
    );
  }
   void launchURL(String url) async{
    if(Platform.isIOS)
      {  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
      if (await launcher.canLaunch(url)) {
        await launcher.launch(
          url,
          useSafariVC: false,
          useWebView: false,
          enableJavaScript: false,
          enableDomStorage: false,
          universalLinksOnly: false,
          headers: <String, String>{},
        );
      } else {
        throw Exception('Could not launch $url');
      }}
    else{
     if (await canLaunch(url)) {
       await launch(url);
     } else {
       print('Could not launch $url');
     }
    }
   }
}

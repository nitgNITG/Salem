import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../core/data/models/logged_user.dart';
import '../../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../../utils/helper_funcs.dart';

class CourseDrawer extends StatefulWidget {
  const CourseDrawer(
    this.controller, {
    super.key
  });
  final CourseProfileController controller;

  @override
  State<CourseDrawer> createState() => _CourseDrawerState();
}

class _CourseDrawerState extends State<CourseDrawer> {
  LoggedUser? loggedUser;
  late final isUserGuest;
  @override
  void initState() {
    String? jonString = SharedPreferencesService.instance
        .getString(SharedPreferencesKeys.loggedUser);
    if (jonString != null) loggedUser = LoggedUser.fromString(jonString);

    isUserGuest = widget.controller.getIsUserGuest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width:getScreenWidth(context)*0.7,
      backgroundColor: getThemeData(context).colorScheme.background,
      child: SizedBox(
        // color: Colors.deepOrangeAccent,
        width:getScreenWidth(context)*0.7,
        height:
            getScreenSize(context).height - MediaQuery.paddingOf(context).top,
        child: Stack(
          children: [
            Column(
              children: [
                Container(width:getScreenWidth(context)*0.7,     alignment: Alignment.center,height:
                getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.2,color:
                HexColor('#45474B'),
                    child: Stack(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width:getScreenHeight(context)/6,height:
                          getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2,
                            child: Image.asset(
                              "assets/images/Asset 3@100x 1 (1).png",
                              width:getScreenHeight(context)/6,height:
                            getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width:getScreenHeight(context)/6,height:
                          getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2,
                            child: Image.asset(
                              "assets/images/Group 421 (1).png",
                              width:getScreenHeight(context)/6,height:
                            getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                const Spacer(),
      Container(width:
      getScreenHeight(context),height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.5:getScreenWidth(context)*0.25,
        child:ListView(  scrollDirection: Axis.vertical,
          shrinkWrap: true,children: [
                ...widget.controller
                    .getPages(context)
                    .map((e) => buildCourseDrawerItem(
                          context,
                          e['index'],
                          e['name'],
                          e['icon'],
                    widget.controller.Icons.elementAt(e['index'])
                        ))
                    .toList()])),
                const Spacer(),
                const Spacer(),

                /// this is the login button of Guest
                if (isUserGuest)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                          icon: Icon(
                            Icons.logout,
                            color:
                                getThemeData(context).colorScheme.onBackground,
                            weight: 20,
                          ),
                          label: Text(
                            getL10(context).login,
                            style: getThemeData(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.bold
                                    // height: 0.9,
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseDrawerItem(
      BuildContext context, int index, String title, String icon1,String? icon2) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),child:
      ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor:HexColor('#F4CE14'),
      minimumSize: Size( getScreenWidth(context)*0.5,
    getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.05:getScreenWidth(context)*0.05)
       ,maximumSize:  Size(getScreenWidth(context)*0.5,
          getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.05:getScreenWidth(context)*0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)
      ),
        onPressed: () async {
          setState(() {
            widget.controller.setPage(index);
          });

          await Future.delayed(const Duration(
            milliseconds: 400,
          ));
          Navigator.of(context).pop();
        },
        child: Container(
            margin: EdgeInsets.all(2),
            width: getScreenWidth(context)*0.5,height:
        getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.05:getScreenWidth(context)*0.05,color:HexColor('#F4CE14'),
            child:  Row(children: [ImageIcon(AssetImage(icon2!),size:getScreenWidth(context)*0.1,color: HexColor('#45474B') ),
              ImageIcon(AssetImage(index==4?'assets/images/setting2.png':icon1),size:getScreenWidth(context)*0.25,color: HexColor('#45474B') )],)
        ),
      ));
  }
}

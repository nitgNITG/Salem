import 'dart:io';
import 'dart:ui';
import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/constants_and_enums/screen_size_constants.dart';
import 'package:al_mariey/app/core/data/models/course.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_page.dart';
import 'package:al_mariey/app/modules/home/home.dart';
import 'package:al_mariey/app/modules/home_page/home_controller.dart';
import 'package:al_mariey/app/modules/register/create_account.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../../main.dart';
import '../../utils/helper_funcs.dart';
import '../login/login_page.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;
  final ScrollController scrollController = ScrollController();


  @override
  void initState() {
    controller = getIt.get<HomeController>();

    Future.wait([
      if (!controller.getIsUserGuest()) controller.getEnrollCourses(),
      controller.getAboutAcademy(),
      controller.getAboutAcademyTeachers(),
      controller.getAboutAcademyFreeLessons(),
      controller.getCategories(),
    ]).then((value) {
     if(mounted) setState(() {});
    });

    super.initState();
  }


  Future<void> refreshCallback() async {
    controller.getCategories();
    if (!controller.getIsUserGuest()) controller.getEnrollCourses();
  }

  final titlesFontSize = 18.0;

  @override
  void dispose() {
    // GetIt.I<HomeController>().dispose();
    super.dispose();
  }
  Widget getAppBarLogoAndModesAndNewsBar(BuildContext context) {
    return Container(
          height:  getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.1:getScreenWidth(context)*0.1 ,
          width: getScreenWidth(context),
          color: HexColor('#45474B'),
          padding:  EdgeInsets.only(top:Platform.isIOS?40: 20,left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:[
              !controller.getIsUserGuest() ?
              IconButton(onPressed: ()  {TC.text='CLICKED';
                scaffoldKey.currentState!.openDrawer();}
              , icon: ImageIcon(AssetImage('assets/images/خطوط.png'),color: HexColor('#F4CE14') )):Text(''),
              Image.asset('assets/images/المرعي.png',color:HexColor('#F4CE14') )
            ],),                                                                       /// ال appBar
        );
  }

  @override
  Widget build(BuildContext context) {
    return  BaseView<HomeController>(
      injectedObject: controller,
      child: SizedBox(
        height: getScreenSize(context).height,
        width: getScreenSize(context).width,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Positioned(
              top: getScreenHeight(context) * 0.12,
              width: getScreenWidth(context),
              child: SizedBox(
                  height: getScreenSize(context).height -
                      ((getScreenSize(context).height * 0.2)) -
                      (controller.getIsUserGuest()? 0 : ScreenSizeConstants.getBottomNavBarHeight(context)),

                  /// this to listeners is to show error widget when the about academy and categories have error
                  ///
                  child: RefreshIndicator(
                    onRefresh: refreshCallback,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Are you teacher  join us
                          ///
                          if (controller.aboutAcademy.isNotEmpty) ...{/// bout Us
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top:getScreenWidth(context)>getScreenHeight(context)?getScreenWidth(context)*0.1: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25)
                                ,color: HexColor('#F3EEEA')
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(bottom: 20,right: 10,left: 10),
                              child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Image.network(controller.aboutAcademy.last,
                                      errorBuilder: (_,w,c)=>Center(child: Icon(Icons.error_outline,color: Colors.black)),
                                      height: getScreenHeight(context)*0.2,
                                        width:MediaQuery.of(context).size.width/3 ),
                              Container(
                                  alignment: Alignment.center,

                                  width: MediaQuery.of(context).size.width/2,child:HtmlWidget(
                                controller.aboutAcademy.first,
                                renderMode: const ColumnMode(),
                                textStyle: TextStyle(
                                  fontFamily: 'Bold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ))
                              ]),
                            )
                          },
                          if (controller.getIsUserGuest())
                           Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(150, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                          backgroundColor: HexColor('#F4CE14')),
                                      onPressed: () {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          routeToPage(
                                            const LoginPage(),
                                          ),
                                              (c) => false,
                                        );
                                        Navigator.of(context).push(
                                          routeToPage(
                                            const RegisterPage(),
                                          ),
                                        );
                                      },
                                      child: getNormalText(
                                        getL10(context).joinUs,
                                        context,
                                        color: HexColor('#45474B'),
                                        weight: FontWeight.bold,
                                         family: 'Bold',
                                      ),
                                    ),                                                               ///زرار ال join us
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(150, 40),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        backgroundColor: HexColor('#008170'),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushAndRemoveUntil(
                                          routeToPage(
                                            const LoginPage(),
                                          ),
                                              (c) => false,
                                        );
                                      },
                                      child: getNormalText(getL10(context).login, context,
                                          family: 'Bold',
                                          color: kOnPrimary, weight: FontWeight.bold),
                                    ),                                                              ///زرار ال  Log in
                                  ],
                                ),
                              ),
                          getHeightSpace(25),
                          ///my class title
                          ///
                          if (!controller.getIsUserGuest() &&
                              controller.myCourses.isNotEmpty) ...{
                            getHeightSpace(20),
                            getTitle(
                                context,
                                family: 'Bold',
                                getL10(context).myClass.toUpperCase(),
                                getL10(context).myClass.length * 12.0,kBlPrimary),

                            /// my class list
                            ///

    Container(
      alignment: Alignment.center,
    height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.5,
    width: getScreenWidth(context)-50,
    child:ListView.separated(
    scrollDirection: Axis.horizontal,
    itemBuilder: (_,i){
    return Container(
            alignment: Alignment.center,
    margin: EdgeInsets.all( 5),
    width: getScreenWidth(context)*0.4, // Adjust the width as needed
    height:getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.5, // Adjust the height as needed
    child:Column(
    children: [
    Image.network(controller.myCourses[i].imageUrl, width: getScreenWidth(context)*0.4, // Adjust the width as needed
        height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.15:getScreenWidth(context)*0.275,fit: BoxFit.fill)
    ,Container(alignment: Alignment.center,color: HexColor('#45474B'), width: getScreenWidth(context)*0.4, // Adjust the width as needed
        height:getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.125:getScreenWidth(context)*0.175,child: Text(controller.myCourses[i].fullname,
    textAlign: TextAlign.center,style:TextStyle(fontSize:
              getScreenWidth(context)<getScreenHeight(context)?
              getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,fontFamily: 'Bold'))
    )] )).onTap(() {  if(controller.getIsUserGuest())
      Exit(context);
    else{
        Navigator.of(context).push(
          routeToPage(
            CourseProfilePage(
              myCourse: controller.myCourses[i],
            ),
          ),
        );
    }});
    }, separatorBuilder: (_,i){
    return SizedBox(width: 0);
    }, itemCount: controller.myCourses.length)

    // SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: controller.aboutAcademyFreeLessons.map<Widget>((url) {
    //       return SizedBox(
    //           width: 180.0, // Adjust the width as needed
    //           height: 180.0, // Adjust the height as needed
    //           child:Image.network(url['imageUrl'])
    //       );
    //     }).toList(),
    //   ),
    // )
    ) }, ValueListenableBuilder(
                              valueListenable: controller.aboutAcademyFreeLessonsState,
                              builder: (context, state, child) {
                                if (state == AppViewState.error) {
                                  return TryAgainErrorWidget(
                                      onclickTryAgain: () {
                                        // controller.getAboutAcademy();
                                        controller.getCategories();
                                      });
                                } else {
                                  return Column(
                                      children: [
                                    if (controller                                    /// المسافه بين ال about academy  والفيديو
                                        .aboutAcademyFreeLessons.isNotEmpty) ...{
                                      getHeightSpace(10),
                                      getTitle(
                                        family: 'Bold',
                                          context,
                                          'الدورات',
                                          getL10(context).aboutAcademy.length *
                                              12.0,Colors.black
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                          height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.5,
                                          width: getScreenWidth(context)-50,
                                          child:ListView.separated(
                                            padding: EdgeInsets.all(0),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (_,i){
                                                return Container(
                                                    margin: EdgeInsets.all( 5),
                                                    width: getScreenWidth(context)*0.4, // Adjust the width as needed
                                                    height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:
                                                    getScreenWidth(context)*0.5,// Adjust the height as needed
                                                    child:Column(
                                                        children: [
                                                          Image.network(controller.aboutAcademyFreeLessons[i]['imageUrl'], width: getScreenWidth(context)*0.4, // Adjust the width as needed
                                                              height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.15:
                                                              getScreenWidth(context)*0.275,fit: BoxFit.fill)
                                                          ,Container(alignment: Alignment.center,color: HexColor('#45474B'), width: getScreenWidth(context)*0.4, // Adjust the width as needed
                                                              height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.125:
                                                              getScreenWidth(context)*0.175,child: Text(controller.aboutAcademyFreeLessons[i]['fullname'],
                                                                  textAlign: TextAlign.center,style: TextStyle(fontSize:
                                                        getScreenWidth(context)<getScreenHeight(context)?
                                                        getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,fontFamily: 'Bold'))
                                                          )] )).onTap((){
                                                            if(controller.getIsUserGuest())
                                                              Exit(context);
                                                            else{
                                                              if(controller.myCourses.firstWhereOrNull((element) =>
                                                              element.id==controller.aboutAcademyFreeLessons[i]['id'])!=null ||
                                                                  controller.getLoggedUser().isAdmin)
                                                                Navigator.of(context).push(
                                                                  routeToPage(
                                                                    CourseProfilePage(
                                                                      course: controller.getLoggedUser().isAdmin?
                                                                      Course.fromJson(controller.aboutAcademyFreeLessons[i]):null,
                                                                      myCourse: controller.getLoggedUser().isAdmin?
                                                                   null: controller.myCourses.firstWhereOrNull((element) => element.id==
                                                                          controller.aboutAcademyFreeLessons[i]['id']  ),
                                                                    ),
                                                                  ),
                                                                );
                                                              else
                                                                Subscribe(context);
                                                            }
                                                });
                                          }, separatorBuilder: (_,i){
                                            return SizedBox(width: 0);
                                          }, itemCount: controller.aboutAcademyFreeLessons.length)



                                      ),                                         /// الفيديو

                                    },
                                  ]);
                                }
                              }),
                          ///about academy title
                          ///
                          ValueListenableBuilder(
                              valueListenable: controller.aboutAcademyState,
                              builder: (context, state, child) {
                                if (state == AppViewState.error) {
                                  return TryAgainErrorWidget(
                                      onclickTryAgain: () {
                                        // controller.getAboutAcademy();
                                        controller.getCategories();
                                      });
                                } else {

                                  return Column(children: [
                                    if (controller                                    /// المسافه بين ال about academy  والفيديو
                                        .aboutAcademyDescription.isNotEmpty) ...{
                                      getHeightSpace(10),
                                      getTitle(
                                        family: 'Bold',
                                        context,
                                        controller.aboutAcademyDescription,
                                        getL10(context).aboutAcademy.length *
                                            12.0,Colors.black
                                      ),
                                      SizedBox(
                                          height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.25:getScreenWidth(context)*0.25,
                                          width: getScreenWidth(context),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: controller.aboutAcademyVideos.map((url) {
                                                return Container(
                                                    margin: EdgeInsets.all(5),
                                                    width: getScreenWidth(context)*0.35, // Adjust the width as needed
                                                    height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2, // Adjust the height as needed
                                                    child:Image.network(url,  width: getScreenWidth(context)*0.35, // Adjust the width as needed
                                                        height: getScreenHeight(context)*0.2,fit: BoxFit.fill)
                                                );
                                              }).toList(),
                                            ),
                                          )
                                      )                                        /// الفيدي
                                    },
                                  ]);
                                }
                              }),
                          ValueListenableBuilder(
                              valueListenable: controller.aboutAcademyTeachersState,
                              builder: (context, state, child) {
                                if (state == AppViewState.error) {
                                  return TryAgainErrorWidget(
                                      onclickTryAgain: () {
                                        // controller.getAboutAcademy();
                                        controller.getCategories();
                                      });
                                } else {
                                  return Column(children: [
                                    if (controller                                    /// المسافه بين ال about academy  والفيديو
                                        .aboutAcademyTeachers.isNotEmpty) ...{
                                      getTitle(
                                        family: 'Bold',
                                          context,
                                          controller.aboutTeachersDescription,
                                          getL10(context).aboutAcademy.length *
                                              12.0,Colors.black
                                      ), SizedBox(
                                          height:  getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.25:
                                          getScreenWidth(context)*0.25,
                                          width: getScreenWidth(context),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: controller.aboutAcademyTeachers.map((url) {
                                                return  Container(
                                                  margin: EdgeInsets.all(5),
                                                    width: getScreenWidth(context)*0.35, // Adjust the width as needed
                                                    height:  getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2, // Adjust the height as needed
                                                      child:Image.network(url,  width: getScreenWidth(context)*0.35, // Adjust the width as needed
                                                        height:  getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.2:getScreenWidth(context)*0.2,fit: BoxFit.fill)
                                                );
                                              }).toList(),
                                            ),
                                          )

                                      ),                                         /// الفيديو

                                    },
                                  ]);
                                }
                              }),

                          //if (controller.aboutAcademyDescription.isNotEmpty) ...{
                          //getHeightSpace(20),
                          //Padding(
                          //padding: const EdgeInsets.all(5),
                          //child: Text(
                          //'kids’ Gallery',style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          //fontSize: 20,
                          //color: Color(0xff003999)),),
                          //),                                                     /// كلمه kid's gallery
                          ///الخط اللي تحت ال Kid's Gallery
                          /// صور الاطفال في الميتنج
                          //},
                           /// المسافه بين الفيديو والdescription
                        ],
                      ),
                    ),
                  )),
            ),
            getAppBarLogoAndModesAndNewsBar(context),
          ],
        ),
      )
      );
  }

  // About Academy
  Row getTitle(BuildContext context, String title, double width,Color color,{String? family}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getWidthSpace(10),
        // about academy
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: kBlPrimary,
                height: 1.8,
                fontFamily:family ,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                decorationColor:color,
              ),
            ), // about academy///الخط اللي تحت ال about academy
          ],
        ),
      ],
    );
  }

  Subscribe(BuildContext context){
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
          content: Container(
            alignment: Alignment.topCenter,
            height:getScreenWidth(context)<getScreenHeight(context)? getScreenHeight(context) * 0.07:getScreenWidth(context)*0.07,
            width: getScreenWidth(context)*0.7,
            child: getNormalText(
              family: 'Bold',
                  getL10(context).subscribe,
                  context,
                  size:  14,
                  color: Colors.white,
                )
          ),
        ),                                                   /// اخر حاجه خالص هل تريد الخروج ام لا
      ),
      barrierDismissible: true,
      barrierColor:
      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
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
                  getL10(context).should,
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
                          Navigator.of(context).pushAndRemoveUntil(
                            routeToPage(
                              const RegisterPage(),
                            ),
                                (c) => false,
                          );
                        },
                        child: Text(
                          getL10(context).joinUs,
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
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            routeToPage(
                              const LoginPage(),
                            ),
                                (c) => false,
                          );
                        },
                        child: Text(
                          getL10(context).login,
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
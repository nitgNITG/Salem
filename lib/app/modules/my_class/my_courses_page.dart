import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_page.dart';
import 'package:al_mariey/app/modules/my_class/my_courses_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../main.dart';
import '../../core/data/models/course.dart';
import '../../core/data/models/my_course.dart';
import '../../core/global_used_widgets/general_use.dart';
import '../home_page/home_controller.dart';

class MyCoursesPage extends StatefulWidget {
  const MyCoursesPage({super.key});

  @override
  State<MyCoursesPage> createState() => _MyCoursesPageState();
}

class _MyCoursesPageState extends State<MyCoursesPage> {
  late final MyCoursesController controller;

  getPageHeight(BuildContext context) {
    return getScreenSize(context).height - getTopPadding(context);
  }

  @override
  void initState() {
    controller = MyCoursesController();
    runGetCourses();
    super.initState();
  }

  runGetCourses() {
    controller.getEnrollCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: BaseView<MyCoursesController>(
        injectedObject: controller,
        child: SizedBox(
          height: getPageHeight(context),
          width: getScreenSize(context).width,
          child: Column(
            children: [
              NormalAppBar(
                title: getL10(context).myClass,),
              ValueListenableBuilder(
                valueListenable: controller.state,
                builder:
                    (BuildContext context, AppViewState value, Widget? child) {
                  print(value.name);
                  if(value.name=='idle' && controller.myCourses.isEmpty)
                    return Column(children: [
                      getHeightSpace(getScreenHeight(context)*0.1),
                      Image.asset('assets/images/Group.png'),
                      getHeightSpace(getScreenHeight(context)*0.02),
                      Image.asset('assets/images/الايميل.png')
                    ],);
                  return Expanded(
                    child:   GridView.count(
                     crossAxisCount: 2,
                     scrollDirection: Axis.vertical,
                     mainAxisSpacing: 16,
                     childAspectRatio: 8/11,
                     cacheExtent: 8,
                     crossAxisSpacing: 16,
                     children : controller.myCourses.map((e) =>SizedBox(
                          height:getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.5,
                          width: getScreenWidth(context)-50,
                          child:        Container(
                          margin: EdgeInsets.all( 5),
                        width: getScreenWidth(context)*0.4, // Adjust the width as needed
                        height:getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.3:getScreenWidth(context)*0.5,// Adjust the height as needed
                        child:SingleChildScrollView(child: Column(
                          mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(e.imageUrl, width: getScreenWidth(context)*0.4, // Adjust the width as needed
                                    height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.15:
                        getScreenWidth(context)*0.275,fit: BoxFit.fill)
                              ,Container(alignment: Alignment.center,color: HexColor('#45474B'), width: getScreenWidth(context)*0.4, // Adjust the width as needed
                                  height: getScreenHeight(context)>getScreenWidth(context)? getScreenHeight(context)*0.125:
                                  getScreenWidth(context)*0.175,child: Text(e.fullname,
                                      textAlign: TextAlign.center,style: TextStyle(fontSize:
                                      getScreenWidth(context)<getScreenHeight(context)?
                                      getScreenWidth(context)*0.03:getScreenHeight(context)*0.03,fontFamily: 'Bold'))
                              )]
                        ))
                          )).onTap(() {
                        if (getIt<HomeController>().getIsUserGuest()) {
                          displayYouNeedLogin(context);
                        } else {
                          Navigator.of(context).push(
                            routeToPage(
                              CourseProfilePage(
                                myCourse: e,
                              ),
                            ),
                          );
                        }
                      })).toList()
                    )
                  );

                },
              )
            ],
          ),
        ),
      ),
    );
  }

  getCourse(int index) {
    return controller.myCourses[index];
  }
}

class CourseOrMyCourseItemFromCoursesPage extends StatelessWidget {
  const CourseOrMyCourseItemFromCoursesPage(
      this.controller, {
        super.key,
        this.course,
        this.myCourse,
      });

  final MyCoursesController controller;
  final Course? course;
  final MyCourse? myCourse;

  String getImageUrl() {
    if (course != null) {
      return course!.imageUrl;
    } else {
      return myCourse!.overviewfiles.firstOrNull == null
          ? ""
          : "${myCourse!.overviewfiles.first.fileurl}?token=${controller.getLoggedUser().token!}";
    }
  }

  String getCourseTitle() {
    if (course != null) {
      return course!.fullName;
    }
    return myCourse!.fullname;
  }

  String getCourseSubTitle() {
    if (course != null) {
      return course!.description!;
    }
    return myCourse!.summary;
  }

  getIsCourse() => course == null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
            getImageUrl(),
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getCourseTitle(),
            style: getThemeData(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: kOnPrimary,
                fontSize: 18,
                height: 1.4,
                backgroundColor: kSecondaryColor.withOpacity(0.3),
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ]),
            textAlign: TextAlign.start,
          ),
          Builder(builder: (context) {
            final summery = getCourseSubTitle();
            return Text(
              summery.substring(0, summery.length > 40 ? 40 : summery.length),
              style: getThemeData(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: kOnPrimary,
                  fontSize: 18,
                  height: 1.4,
                  backgroundColor: kSecondaryColor.withOpacity(0.3),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ]),
              textAlign: TextAlign.start,
            );
          }),
          ElevatedButton(onPressed: () {}, child: const Text("المزيد")),
          const Spacer(),

          /// progress visible if not guest
          if (getIsCourse())
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: getScreenSize(context).width * 0.72,
                  child: LinearProgressIndicator(
                    value: (myCourse!.progress / 100),
                    minHeight: 12,
                    color: kSecondaryColor,
                    backgroundColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                getWidthSpace(10),
                Container(
                  color: kSecondaryColor.withOpacity(0.3),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    ("${myCourse!.progress.floorToDouble()}%"),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

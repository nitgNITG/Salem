import 'dart:ui';

import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/data/models/course.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_controller.dart';
import 'package:al_mariey/app/modules/course_profile/items/course_drawer.dart';
import 'package:al_mariey/app/modules/global_used_widgets/widget_methods.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/data/models/my_course.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../utils/helper_funcs.dart';
import '../../widgets/app_bars.dart';

class CourseProfilePage extends StatefulWidget {
  const CourseProfilePage({super.key, this.myCourse, this.course});

  final MyCourse? myCourse;
  final Course? course;

  @override
  State<CourseProfilePage> createState() => _CourseProfilePageState();
}

class _CourseProfilePageState extends State<CourseProfilePage>
    with TickerProviderStateMixin {
  late final CourseProfileController controller;

  @override
  void initState() {
    controller = CourseProfileController();
    controller.getCourseDetails(getCourseId());

    // controller.isEnrolledToCourse.addListener(() {
    //   if (!controller.isEnrolledToCourse.value) {
    //     showMyDialog();
    //   }
    // });
    super.initState();
  }

  showMyDialog() {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 1.5,
        ),
        child: AlertDialog(
          backgroundColor: HexColor('#45474B'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title:Row(mainAxisAlignment: MainAxisAlignment.start,children: [
            InkWell(onTap: ()=>Navigator.pop(context),child: Icon(Icons.close,color: Colors.white))]),
          actionsAlignment: MainAxisAlignment.start,
          content: SizedBox(
            height: getScreenHeight(context) * 0.05,
            width: getScreenWidth(context)*0.4,
            child: Column(
              children: [
                getNormalText(
                  "انت غير مشترك في هذه الدوره",
                  context,
                  family: 'Medium',
                  size: getScreenHeight(context)*0.02,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.15),
    );
  }

  String getCourseId() {
    return widget.course == null ? widget.myCourse!.id : widget.course!.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, state, widget) {
            if (state == AppViewState.idle &&
                controller.isUserTeacherOfThisCourseOrAdmin()) {
              return CourseDrawer(controller);
            }
            return const SizedBox();
          }),
      body: Stack(
        children: [
          getAppPostionedBackground(context),
          Column(
            children: [
              StreamBuilder<ConnectivityResult>(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    if (snapshot.data != ConnectivityResult.none) {
                      return NormalAppBar(
                        title: getTitle(),
                        trailing: ValueListenableBuilder(
                          valueListenable: controller.state,
                          builder: (context, state, child) {
                            if (state == AppViewState.idle &&
                                controller.isUserTeacherOfThisCourseOrAdmin()) {
                              return  Icon(
                                Icons.menu,
                                color: HexColor('#F4CE14'),
                                size: 30,
                              ).onTap(() {
                                Scaffold.of(context).openDrawer();
                              });
                            }
                            return const SizedBox();
                          },
                        ),
                      );
                    }
                    return Container();
                  }),
              Expanded(
                child: BaseView<CourseProfileController>(
                  injectedObject: controller,
                  child: ValueListenableBuilder<AppViewState>(
                    valueListenable: controller.state,
                    builder: (context, state, widget) =>
                        getWidgetDependsInAppViewState(state, onClick: () {
                      controller.getCourseDetails(getCourseId());
                    },
                            PageView.builder(
                              controller: controller.pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.getPages(context).length,
                              itemBuilder: (context, index) => controller
                                  .getPages(context)
                                  .elementAt(index)['widget'],
                            )),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String getSubTitle() {
    if (widget.course != null) {
      return widget.course!.fullName;
    }
    return widget.myCourse!.fullname;
  }

  String getImage() {
    if (widget.course != null) {
      return widget.course!.imageUrl;
    }
    return widget.myCourse!.imageUrl;
  }

  String getTitle() {
    if (widget.course != null) {
      return widget.course!.shortName;
    }
    return widget.myCourse!.shortname;
  }
}

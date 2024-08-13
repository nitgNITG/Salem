import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/teacher_profile/teacher_profile_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';

import '../../core/data/models/teacher.dart';
import '../../widgets/app_bars.dart';
import '../global_used_widgets/widget_methods.dart';

class TeacherDetailsPage extends StatefulWidget {
  const TeacherDetailsPage(this.teacher, {super.key});

  final Teacher teacher;

  @override
  State<TeacherDetailsPage> createState() => _TeacherDetailsPageState();
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {
  late final TeacherProfileController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TeacherProfileController();
    controller.getTeacherDetails(widget.teacher.id).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherProfileController>(
      injectedObject: controller,
      child: Scaffold(
        body: SizedBox(
          height: getScreenHeight(context),
          width: getScreenWidth(context),
          child: Stack(
            children: [
              getAppPostionedBackground(context),

              /// the blue curved rectabnge
              SizedBox(
                height: getScreenSize(context).height * 0.16,
                child: Container(
                  decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: const Alignment(
                        -0.65,
                        0.96,
                      ),
                      end: const Alignment(1, 1),
                      colors: [
                        // Color(0xFF042F53),
                        const Color(
                          0xE21269B3,
                        ).withOpacity(0.8),

                        const Color(
                          0xE21269B3,
                        ).withOpacity(0.8),
                      ],
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      NormalAppBar(
                        title: "${widget.teacher.firstname} ${widget.teacher.lastname}",
                        obacity: 0.1,
                      ),
                      getHeightSpace(10),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: getScreenSize(context).height * 0.095,
                width: getScreenWidth(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.teacher.imgUrl,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: getScreenSize(context).height * 0.31,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: getScreenHeight(context) -
                        (getScreenSize(context).height * 0.31),
                    width: getScreenWidth(
                      context,
                    ),
                    child: getWidgetDependsInAppViewState(
                      controller.state.value,
                      SingleChildScrollView(
                        child: Builder(builder: (context) {
                          return controller.details != null
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          getL10(context).studentsCount,
                                          style: getThemeData(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          controller.students_count.toString(),
                                          style: getThemeData(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                          softWrap: true,
                                        )
                                      ],
                                    ),
                                    buildNormalColumn(
                                      context,
                                      getL10(context).teacherDescription,
                                      controller.details!.description ?? "",
                                    ),
                                    buildNormalColumn(
                                      context,
                                      getL10(context).certificates,
                                      controller.joinListAsString(
                                          controller.certificates,
                                          "certificate"),
                                    ),
                                    buildNormalColumn(
                                      context,
                                      getL10(context).courses,
                                      controller.joinListAsString(
                                          controller.obtainedCerts, "course"),
                                    ),
                                    buildNormalColumn(
                                      context,
                                      getL10(context).workshops,
                                      controller.joinListAsString(
                                          controller.workShops, "workshop"),
                                    ),
                                    buildNormalColumn(
                                      context,
                                      getL10(context).experiences,
                                      controller.joinListAsString(
                                        controller.experiences,
                                        "experience",
                                      ),
                                    ),
                                     Divider(
                                      thickness: 2,
                                      color: kSecondaryColor,
                                    ),
                                    Row(
                                      children: [
                                        getNormalText(
                                          getL10(context).availableCourses,
                                          context,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                   /*  SizedBox(
                                      width: getScreenWidth(context),
                                      height: 140,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            CourseItemHomePage(
                                                myCourse:
                                                    controller.courses[index],
                                                teacherName: "${controller
                                                        .details!.firstname} ${controller
                                                        .details!.lastname}"),
                                        itemCount: controller.courses.length,
                                        scrollDirection: Axis.horizontal,
                                      ),
                                    ), */
                                    getHeightSpace(10)
                                  ],
                                )
                              : Container();
                        }),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Column buildNormalColumn(
  BuildContext context,
  String title,
  String body,
) {
  return Column(
    children: [
       Divider(
        thickness: 2,
        color: kSecondaryColor,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getNormalText(title, context, weight: FontWeight.bold),
          getWidthSpace(20),
        ],
      ),
      getNormalText(body, context, color: kPrimaryColor),
    ],
  );
}

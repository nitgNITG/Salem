
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/student_profile/sub_widgets/edit_profile_bottom_sheet.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/image_picker.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import '../../core/themes/colors.dart';
import '../../widgets/app_bars.dart';
import '../global_used_widgets/widget_methods.dart';
import '../home_page/helper_widgets/my_course_item.dart';
import 'profile_controller.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  late final ProfileController2 controller;

  @override
  void initState() {
    controller = ProfileController2();
    controller.getAllCourses().then((value) {
      setState(() {});
    });
    controller.StudentDetail().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenSize(context).height,
      width: getScreenSize(context).width,
      child: BaseView<ProfileController2>(
        injectedObject: controller,
        child: Scaffold(
          body: Container(
            height: getScreenSize(context).height,
            width: getScreenSize(context).width,
            color: getThemeData(context).colorScheme.background,
            child: Builder(builder: (context) {
              final logedUser = controller.user;
              return Stack(
                children: [
                  getAppPostionedBackground(context),
                  RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getScreenSize(context).height * 0.25,
                            child: Container(
                              decoration: ShapeDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    const Color(0xFF042F53).withOpacity(0.8),
                                    const Color(0xE21269B3,).withOpacity(0.8),
                                    const Color(0xE21269B3,).withOpacity(0.8),
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
                                    title: getL10(context).profile,
                                    obacity: 0.1,
                                  ),
                                  const Spacer(),
                                  Builder(builder: (context) {
                                    final loggedUser =
                                        controller.getLoggedUser();
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        getWidthSpace(
                                            getScreenWidth(context) * 0.2),
                                        ImagePickerWidget(
                                          edit: true,
                                            loggedUser: loggedUser),
                                        getWidthSpace(10),
                                        Column(
                                          children: [
                                            getNormalText(
                                              "${loggedUser.firstName} ${loggedUser.lastName}",
                                              context,
                                              color: kOnPrimary,
                                              weight: FontWeight.bold,
                                            ),
                                            getNormalText(
                                              loggedUser.email,
                                              context,
                                              color: kOnPrimary,
                                              weight: FontWeight.bold,
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                  const Spacer()
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),

                            /// this heights is come from top they are of the stacks
                            width: getScreenWidth(context),
                            height: getScreenHeight(context) * 0.75,
                            child: RefreshIndicator(
                              onRefresh: () async {
                                setState(() {});
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getHeightSpace(
                                      (getScreenSize(context).height * 0.03),
                                    ),

                                    /// the title data and the edit icon
                                    Row(
                                      children: [
                                        const Spacer(),
                                        getTitleText(
                                          getL10(context).personalData,
                                          context,
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.edit_calendar_sharp)
                                            .onTap(() {
                                          controller.setDataForBottomSheet();
                                          showBottomSheet(
                                              context: context,
                                              constraints:
                                                  BoxConstraints.expand(
                                                      height: getScreenHeight(
                                                              context) -
                                                          MediaQuery.paddingOf(
                                                                  context)
                                                              .top),
                                              builder: (context) =>
                                                  EditProfileBottomSheet(
                                                    controller: controller,
                                                  ));
                                          // buildBottomSheet(context);
                                        })
                                      ],
                                    ),

                                    getHeightSpace(10),
                                  
                                    getRowItemProfile(context,
                                        getL10(context).email, logedUser!.email),
                                    getRowItemProfile(context,
                                        getL10(context).phone, logedUser.phone),


                                      getRowItemProfile(
                                        context,
                                        getL10(context).numberOfEnrolledCourses,
                                        logedUser.coursesCount.toString()
                                        /* controller.myCoursesList.length == 0
                                          ? ""
                                          : controller.myCoursesList.length
                                              .toString(), */
                                        ),
                                  
                                    getRowItemProfile(
                                        context,
                                        getL10(context).nationalIdNumber,
                                        logedUser.firstName+' '+logedUser.lastName),
                                    getHeightSpace(20),

                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              getScreenSize(context).width *
                                                  0.1),
                                      child: getTitleText(
                                          getL10(context).myCourses, context,
                                          weight: FontWeight.bold),
                                    ),
                                    getHeightSpace(10),
                                    SizedBox(
                                      height: 150,
                                      width: getScreenSize(context).width,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.myCoursesList.length,
                                        itemBuilder: (context, index) => Column(
                                          children: [
                                            MyCourseItem(
                                                controller: controller,
                                                item: controller
                                                    .myCoursesList[index]),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// this is the my courses under the card
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget getRowItemProfile(BuildContext context, title, value) {
    return Column(
      children: [
        getHeightSpace(10),
        getNormalText(title + " / " + value, context, weight: FontWeight.bold),
      ],
    );
  }
}

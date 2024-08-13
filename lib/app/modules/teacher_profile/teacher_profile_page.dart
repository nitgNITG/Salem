import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/teacher_profile/teacher_profile_controller.dart';
import 'package:al_mariey/app/widgets/form_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/themes/colors.dart';
import '../../utils/helper_funcs.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/image_picker.dart';
import '../../widgets/status_widgets.dart';
import '../../widgets/texts.dart';
import '../base/base_view.dart';
import '../global_used_widgets/widget_methods.dart';
import '../home_page/helper_widgets/course_item.dart';
import '../student_profile/sub_widgets/edit_profile_bottom_sheet.dart';
import 'teacher_details_page.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({
    super.key,
    required this.loggedUser,
  });

  final LoggedUser loggedUser;

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  late final TeacherProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = TeacherProfileController();
    controller.getTeacherDetails(widget.loggedUser.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherProfileController>(
      injectedObject: controller,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: getScreenHeight(context),
            width: getScreenWidth(context),
            child: Stack(
              children: [
                getAppPostionedBackground(context),
                SizedBox(
                  height: getScreenSize(context).height * 0.2,
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

                    ///  the image and name
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalAppBar(
                          title: getL10(context).profile,
                          obacity: 0.1,
                        ),
                        const Spacer(),
                        Builder(builder: (context) {
                          final loggedUser = controller.getLoggedUser();
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getWidthSpace(getScreenWidth(context) * 0.1),
                              ImagePickerWidget(loggedUser: loggedUser,edit: true),
                              getWidthSpace(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
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
                              const Spacer(),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.edit_document,
                                  size: 30,
                                  color: kOnPrimary,
                                ),
                              ).onTap(() {
                                controller.setDataForBottomSheet();
                                showBottomSheet(
                                    context: context,
                                    constraints: BoxConstraints.expand(
                                        height: getScreenHeight(context) -
                                            MediaQuery.paddingOf(context).top),
                                    builder: (context) =>
                                        EditProfileBottomSheet(
                                          controller: controller,
                                        ));
                              })
                            ],
                          );
                        }),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: getScreenSize(context).height * 0.21,
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: getScreenHeight(context) -
                          (getScreenSize(context).height * 0.21),
                      width: getScreenWidth(
                        context,
                      ),
                      child: ValueListenableBuilder(
                          valueListenable: controller.state,
                          builder: (context, state, widget) {
                            return getWidgetDependsInAppViewState(
                              controller.state.value,
                              SingleChildScrollView(
                                child: Builder(builder: (context) {
                                  return controller.details != null
                                      ? Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  getL10(context).studentsCount,
                                                  style: getThemeData(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                                Text(
                                                  controller.students_count
                                                      .toString(),
                                                  style: getThemeData(context)
                                                      .textTheme
                                                      .displayMedium!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                  softWrap: true,
                                                )
                                              ],
                                            ),
                                            buildNormalColumn(
                                              context,
                                              getL10(context)
                                                  .teacherDescription,
                                              controller.details!.description ??
                                                  "",
                                            ),
                                            RowItem(
                                                title: getL10(context)
                                                    .certificates,
                                                list: controller.certificates,
                                                listKey: "certificate"),
                                            //            certificate
                                            RowItem(
                                                title: getL10(context).courses,
                                                list: controller.obtainedCerts,
                                                listKey: "course"),
                                            RowItem(
                                                title:
                                                    getL10(context).workshops,
                                                list: controller.workShops,
                                                listKey: "workshop"),
                                            RowItem(
                                              title:
                                                  getL10(context).experiences,
                                              list: controller.experiences,
                                              listKey: "experience",
                                            ),
                                             Divider(
                                              thickness: 2,
                                              color: kSecondaryColor,
                                            ),

                                            /// my courses
                                            Row(
                                              children: [
                                                getNormalText(
                                                  getL10(context)
                                                      .availableCourses,
                                                  context,
                                                  weight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                            getHeightSpace(10),
                                          /*   SizedBox(
                                              width: getScreenWidth(context),
                                              height: 140,
                                              child: ListView.builder(
                                                itemBuilder: (context, index) =>
                                                    CourseItemHomePage(
                                                        myCourse: controller
                                                            .courses[index],
                                                        teacherName: "${controller
                                                                .details!
                                                                .firstname} ${controller.details!
                                                                .lastname}"),
                                                itemCount:
                                                    controller.courses.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                              ),
                                            ), */
                                            getHeightSpace(10)
                                          ],
                                        )
                                      : Container();
                                }),
                              ),
                            );
                          })),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RowItem extends StatefulWidget {
  const RowItem({
    super.key,
    required this.title,
    required this.list,
    required this.listKey,
  });

  final List list;
  final String title, listKey;

  @override
  State<RowItem> createState() => _RowItemState();
}

class _RowItemState extends State<RowItem> {
  bool showAddField = false;
  late final TeacherProfileController controller;
  final textEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = Provider.of<TeacherProfileController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Divider(
          thickness: 2,
          color: kSecondaryColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getNormalText(widget.title, context, weight: FontWeight.bold),
            // getWidthSpace(20),
            Icon(
              !showAddField ? Icons.add_circle_outlined : Icons.remove_circle,
            ).onTap(() {
              setState(() {
                showAddField = !showAddField;
              });
            })
          ],
        ),
        if (widget.list.isNotEmpty)
          ...widget.list.map((e) {
            // print((e)[widget.listKey].toString());
            return SizedBox(
              width: getScreenWidth(context) * 0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.remove_circle,
                    color: Colors.red.withOpacity(0.8),
                  ).onTap(() {
                    final theKey = widget.listKey == "course"
                        ? "newcourse"
                        : widget.listKey;
                    controller.removeTecherProperty("${theKey}id", e['id']);
                  }),
                  getWidthSpace(10),
                  getNormalText((e)[widget.listKey], context,
                      color: kPrimaryColor),
                ],
              ),
            );
          }).toList(),
        if (showAddField)
          (Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getScreenWidth(context) * 0.5,
                child: TextFormFieldWidget(
                  title: "",
                  fillColor: Colors.grey,
                  controller: textEditController,
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final theKey = widget.listKey == "course"
                        ? "newcourse"
                        : widget.listKey;
                    controller.addTecherProperty(
                        theKey, textEditController.text.toString());
                  },
                  child: const Text("اضافة"))
            ],
          ))
      ],
    );
  }
}

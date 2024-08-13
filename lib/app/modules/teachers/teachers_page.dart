import 'package:al_mariey/app/core/data/models/teacher.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/global_used_widgets/widget_methods.dart';
import 'package:al_mariey/app/modules/teacher_profile/teacher_details_page.dart';
import 'package:al_mariey/app/modules/teachers/teachers_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:flutter/material.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key, this.mainPage = true});

  final bool mainPage;

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  late final TeachersController controller;
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    controller = TeachersController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<TeachersController>(
          injectedObject: controller,
          child: Stack(
            children: [
              getAppPostionedBackground(context),
              SizedBox(
                width: getScreenSize(context).width,
                height: getScreenSize(context).height,
                child: ValueListenableBuilder(
                  valueListenable: controller.state,
                  builder: (context, appViewState, child) => Column(
                    children: [
                      NormalAppBar(
                        title: getL10(context).trainees,
                        trailing: null,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: getScreenWidth(context) * 0.7,
                        height: 40,
                        child: TextFormField(
                          focusNode: focusNode,
                          onChanged: (str) {
                            setState(() {
                              controller.filter(str);
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: kSecondaryColor.withOpacity(0.5),
                            hintText: getL10(context).searchByNameOrJob,
                            hintStyle: TextStyle(
                              color: getThemeData(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Builder(builder: (context) {
                          int temp = 0;
                          return GridView.count(
                            crossAxisCount: 2,
                            children: controller.filteredTeachers.mapIndexed(
                              (index, e) {
                                if (index % 2 == 0) {
                                  temp += 3;
                                }
                                return TeacherItem(e,
                                        index: temp % 2 == 0 ? 0 : 1)
                                    .onTap(
                                  () {
                                    Navigator.of(context).push(
                                      routeToPage(
                                        TeacherDetailsPage(e),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class TeacherItem extends StatelessWidget {
  const TeacherItem(this.item, {super.key, required this.index});

  final Teacher item;
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemWidth = getScreenSize(context).width * 0.5;

    return Container(
      // height: 120,
      width: itemWidth,

      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kSecondaryColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(
              0,
              3,
            ), // changes position of shadow
          ),
        ],
      ),
      // color: getRandomQuietColor(),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 120,
            width: itemWidth,
            decoration: BoxDecoration(
              color: index == 0
                  ? kSecondaryColor
                  : kSecondaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      truncateString("${item.firstname} ${item.lastname}", 10),
                      style: getThemeData(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: index == 0
                                ? kOnPrimary
                                : getThemeData(context)
                                    .colorScheme
                                    .onBackground,
                          ),
                    ),
                    SizedBox(
                      width: itemWidth / 2,
                      child: Text(
                        truncateString(item.job, 22),
                        style: getThemeData(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: index == 0
                                  ? kOnPrimary
                                  : getThemeData(context)
                                      .colorScheme
                                      .onBackground,
                            ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                        // overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundImage: NetworkImage(item.imgUrl),
                  radius: (getScreenSize(context).width * 0.45) * 0.12,
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              height: 70,
              width: itemWidth - 10 - 20,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: kOnPrimary,
                boxShadow: [
                  BoxShadow(
                    color: kSecondaryColor.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(
                      0,
                      3,
                    ), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "${getL10(context).studentsNumber} : ${item.studentsCount}",
                      style: getThemeData(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                          ),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.fade,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 20,
                          color:
                              index <= item.rate ? kPrimaryColor : Colors.grey,
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
    );
  }
}

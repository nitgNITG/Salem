import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/course_profile/items/moduleItem.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../core/data/models/course_details.dart';
import '../course_profile_controller.dart';

class CourseContent extends StatefulWidget {
  const CourseContent({super.key});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  String? openedIndex;

  openIndex(String? i) {
    setState(() {
      openedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<CourseProfileController>(context, listen: false);
    CourseDetails details = controller.courseDetails;
    return Column(
      children: [
        getHeightSpace(10),
        ...details.contents.map((e) => buildSectionItem(context, e))
      ],
    );
  }

  Widget buildSectionItem(BuildContext context, Section section) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: HexColor('#45474B'),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' '),
              getNormalText(
                truncateString(
                    section.name, getScreenWidth(context).toInt() ~/ 9),
                context,
                family: 'Candal',
                color: HexColor('#F4CE14'),
              ),
               Icon(
                openedIndex == section.id
                    ? Icons.keyboard_arrow_up_sharp
                    : Icons.keyboard_arrow_down_sharp,
                size: 30,
                color: HexColor('#F4CE14'),
              )
            ],
          ),
        ).onTap(() {
          openIndex(section.id == openedIndex ? null : section.id);
        }),
        if (openedIndex == section.id)
    Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(5),
    height: (getScreenHeight(context)*0.05)*(section.modules.map((e) => ModuleItem(module: e)).toList().length+2),
    width: getScreenWidth(context),
    color: HexColor('#D9D9D9'),
    child:Column(
            children:
                section.modules.map((e) => ModuleItem(module: e)).toList(),
          )),
        getHeightSpace(10)
      ],
    );
  }
}

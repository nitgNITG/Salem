import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/helper_funcs.dart';
import '../../../widgets/video_player.dart';
import '../course_profile_controller.dart';
import '../items/course_content.dart';

class CourseInfoWidget extends StatefulWidget {
  const CourseInfoWidget({super.key});

  @override
  State<CourseInfoWidget> createState() => _CourseInfoWidgetState();
}

class _CourseInfoWidgetState extends State<CourseInfoWidget> {
  late final CourseProfileController controller;

  @override
  void initState() {
    super.initState();

    controller = Provider.of<CourseProfileController>(context, listen: false);
  }

  int tabIndex = 0;

  setTabIndex(int i) {
    setState(() {
      tabIndex = i;
    });
  }

  List<String> getTitles(context) => [
        // getL10(context).aboutCourse,
        getL10(context).courseContent,
        // getL10(context).forum,
        // getL10(context).trainigCenters
      ];

  List<Widget> items = [
    const CourseContent(),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // getHeightSpace(10),

          /// the video player
          const OnlineSessionButton(),
          getHeightSpace(10),

          /// the tabs of course info
          items.elementAt(tabIndex)
        ],
      ),
    );
  }
}

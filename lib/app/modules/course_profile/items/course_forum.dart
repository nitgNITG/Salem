
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';

class CourseForum extends StatefulWidget {
  const CourseForum({super.key});

  @override
  State<CourseForum> createState() => _CourseForumState();
}

class _CourseForumState extends State<CourseForum> {
  final list = [
    Map.of(
      {
        "name": "@username",
        "image": "https://picsum.photos/200/201",
        "date": "منذ يومين",
        "comment": "ياريت حضرتك توضحلي ازاي اطبق الكورس",
      },
    ),
    Map.of(
      {
        "name": "@username",
        "image": "https://picsum.photos/200/201",
        "date": "منذ ساعة",
        "comment": "ياريت حضرتك توضحلي ازاي اطبق الكورس",
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: getScreenSize(context).height * 0.5,
        // color: getRandomQuietColor(),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...list.map((e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: getRandomQuietColor(),
                                radius: 20,
                              ),
                              getWidthSpace(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getNormalText(
                                      "${e["name"]!} . ${e["date"]!}", context),
                                  getHeightSpace(5),
                                  getNormalText(
                                    e["comment"]!,
                                    context,
                                    color: getThemeData(context)
                                        .colorScheme
                                        .onSurface,
                                  )
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
            getTitleText("enter connet", context),
          ],
        ),
      ),
    );
  }
}

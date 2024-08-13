import 'package:al_mariey/app/core/data/models/my_course.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import '../../../core/data/models/course.dart';
import '../../../core/themes/colors.dart';
import '../../../utils/helper_funcs.dart';

class CourseItemHomePage extends StatelessWidget {
  const CourseItemHomePage({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Container(
            width: 150,
            height: 80,
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: getThemeData(context).colorScheme.background,
              boxShadow: getBoxShadow(context),
            ),
            child: Image.network(course.imageUrl),
          ),
          Positioned(
            top: 80,
            left: 8,
            child: Container(
              height: 40,
              width: 152,
              alignment: Alignment.bottomCenter,
              child: SizedBox.expand(
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: kPrimaryColor,
                    disabledBackgroundColor: kPrimaryColor,
                  ),
                  child: getNormalText(
                    truncateString(course.fullName, 17),
                    context,
                    color: kOnPrimary,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CourseItemMyCourse extends StatelessWidget {
  const CourseItemMyCourse({
    super.key,
    required this.myCourse,
  });

  final MyCourse myCourse;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Container(
        // height: 2000,
        width: 150,
        // color: getRandomQuietColor(),
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Container(
              width: 150,
              height: 100,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: getThemeData(context).colorScheme.background,
                boxShadow: getBoxShadow(context),
              ),
              child: Image.network(
                myCourse.imageUrl,
                height: 100,
                width: 150,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              top: 100,
              left: 8,
              child: Container(
                height: 40,
                width: 140,
                alignment: Alignment.bottomCenter,
                child: SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff002E94),
                                Color(0xff00FFFF)
                              ]
                          )
                      ),
                      child: TextButton(
                          onPressed: null,
                          child: getNormalText(
                            truncateString(
                              myCourse.fullname,
                              14,
                            ),

                            context,
                          )
                      ),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

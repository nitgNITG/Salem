import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/modules/my_class/my_courses_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../core/global_used_widgets/general_use.dart';
import '../../utils/routing_utils.dart';
import '../course_profile/course_profile_page.dart';
import '../home_page/helper_widgets/course_item.dart';
import '../home_page/home_controller.dart';
import '../my_class/my_courses_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage( {required this.controller, super.key});

  final MyCoursesController controller;


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    widget.controller.myCoursesFiltered = widget.controller.myCourses;
   
  }

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: getScreenHeight(context),
        width: getScreenWidth(context),
        child: Column(
          children: [
            getHeightSpace(MediaQuery.of(context).padding.top + 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                  child: const Icon(
                    Icons.arrow_back,
                    weight: 5,
                    size: 30,
                  ),
                ).onTap(() {
                  Navigator.of(context).pop();
                }),
                SizedBox(
                  width: getScreenWidth(context) * 0.7,
                  child: TextFormField(
                    focusNode: focusNode,
                    onChanged: (str) {
                      setState(() {
                        widget.controller.filter(str);
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.5),
                      hintText: getL10(context).enterAnyNameToSearch,
                    ),

                    style: getThemeData(context).textTheme.displayMedium,
                  ),
                ),
                Container()
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount:widget.controller.myCoursesFiltered.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 15 / 11
                  // mainAxisSpacing: 8.0,
                  // mainAxisExtent: 1.0,
                ),
                itemBuilder: (context, index) => CourseItemMyCourse(
                  myCourse: widget.controller.myCoursesFiltered[index],
                ).onTap(() {
                  if (getIt<HomeController>().getIsUserGuest()) {
                    displayYouNeedLogin(context);
                  } else {
                    Navigator.of(context).push(
                      routeToPage(
                        CourseProfilePage(
                          myCourse: widget.controller.myCoursesFiltered[index],
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

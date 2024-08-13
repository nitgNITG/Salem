import 'package:al_mariey/app/core/data/models/category.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/course_categories/course_categories_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';

import '../../core/themes/colors.dart';

class CourseCategoriesPage extends StatefulWidget {
  static const name = "categoris";

  const CourseCategoriesPage({super.key});

  @override
  State<CourseCategoriesPage> createState() => _CourseCategoriesPageState();
}

class _CourseCategoriesPageState extends State<CourseCategoriesPage> {
  late final CourseCategoriesController controller;
  @override
  void initState() {
    super.initState();
    controller = CourseCategoriesController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(
        injectedObject: controller,
        child: Column(
          children: [
            NormalAppBar(title: getL10(context).trainingProvissions),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller.state,
                builder: (context, state, child) {
                  return getWidgetDependsInAppViewState(
                      state, const TrainingProvissionsBody());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrainingProvissionsBody extends StatelessWidget {
  const TrainingProvissionsBody({super.key});

  CourseCategoriesController getController(context) {
    return Provider.of<CourseCategoriesController>(context, listen: false);
  }

  List<CourseCategory> getCategoriesList(context) {
    return getController(context).categories;
  }

  @override
  Widget build(BuildContext context) {
    const height = 150.0;
    final width = getScreenWidth(context) * 0.9;
    final categorisList = getCategoriesList(context);
    return ListView.builder(
        itemCount: categorisList.length,
        itemBuilder: (context, index) => Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              categorisList[index].image,
                            ),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              kSecondaryColor,
                              kSecondaryColor.withOpacity(0.7),
                              kSecondaryColor.withOpacity(0.5),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    PositionedDirectional(
                        top: 10,
                        start: 10,
                        width: width - 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getNormalText(categorisList[index].name, context,
                                color: kOnPrimary, weight: FontWeight.bold),
                            getHeightSpace(10),
                            if (isHTMLTag(categorisList[index].description!))
                              SizedBox(
                                width: getScreenWidth(context) * 0.6,
                                child: HtmlWidget(
                                  // the first parameter (`html`) is required
                                  categorisList[index].description!,

                                  textStyle: TextStyle(fontSize: 14),
                                ),
                              )
                            else
                              SizedBox(
                                width: getScreenWidth(context) * 0.6,
                                child: getNormalText(
                                  truncateString(
                                      categorisList[index].description!, 60),
                                  context,
                                  color: kOnPrimary,
                                ),
                              ),
                          ],
                        )),
                    PositionedDirectional(
                      end: 0,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: kOnPrimary,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            bottomStart: Radius.circular(5),
                          ),
                        ),
                        child: getNormalText(
                          "${getL10(context).coursesCount} ${categorisList[index].coursecount}",
                          context,
                          color: kSecondaryColor,
                        ),
                      ),
                    ),
                    PositionedDirectional(
                      end: 10,
                      bottom: 10,
                      child: ElevatedButton(
                        onPressed: () {
                         /*  Navigator.of(context).push(
                            routeToPage(
                              CoursesOfCategory(
                                courseCategory: categorisList[index],
                              ),
                            ),
                          ); */
                        },
                        child: Text(
                          getL10(context).more,
                          style: TextStyle(color: kOnPrimary),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

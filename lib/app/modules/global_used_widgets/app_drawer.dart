
import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:al_mariey/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/contact_us/contact_us.dart';
import 'package:al_mariey/app/modules/course_categories/course_categories_page.dart';
import 'package:al_mariey/app/modules/news/news_page.dart';
import 'package:al_mariey/app/modules/splash/splash_page.dart';
import 'package:al_mariey/app/modules/teachers/teachers_page.dart';
import 'package:al_mariey/app/modules/web_view/view/web_view.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../student_profile/profile_page.dart';
import '../teacher_profile/teacher_profile_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer(this.isUserGuest, {super.key});

  final bool isUserGuest;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  LoggedUser? loggedUser;

  @override
  void initState() {
    String? jonString = SharedPreferencesService.instance
        .getString(SharedPreferencesKeys.loggedUser);
    if (jonString != null) loggedUser = LoggedUser.fromString(jonString);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getScreenSize(context).width * 0.7,
      backgroundColor: getThemeData(context).colorScheme.background,
      child: SizedBox(
        // color: Colors.deepOrangeAccent,
        width: getScreenSize(context).width * 0.7,
        height:
            getScreenSize(context).height - MediaQuery.paddingOf(context).top,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                "assets/images/app_bg.svg",
                height: getScreenSize(context).height -
                    MediaQuery.paddingOf(context).top,
                width: getScreenSize(context).width * 0.7,
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                  getThemeData(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.08),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: getScreenSize(context).height * 0.05),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/drawer_bg.png",
                            height: getScreenSize(context).height * 0.25,
                            width: getScreenSize(context).width * 0.7,
                            fit: BoxFit.fill,
                          ),
                          PositionedDirectional(
                            top: 0,
                            start: 0,
                            end: 0,
                            bottom: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/app_logo.png",
                                  width: 70,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// user data
                    if (!widget.isUserGuest)
                      PositionedDirectional(
                        top: getTopPadding(context),
                        start: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: kOnPrimary,
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            children: [
                              Image.network(
                                loggedUser!.image,
                                width: 30,
                              ),
                              getWidthSpace(10),
                              Text(loggedUser!.firstName),
                            ],
                          ).onTap(() {
                            Navigator.of(context).push(routeToPage(
                              loggedUser!.role == "student"
                                  ? const StudentProfile()
                                  : TeacherProfilePage(loggedUser: loggedUser!),
                            ));
                          }),
                        ),
                      ),
                    Positioned(
                      width: getScreenSize(context).width * 0.7,
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            // height: 50,
                            // width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color:
                                  getThemeData(context).colorScheme.background,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  getL10(context).ministryOfManpower,
                                  style: getThemeData(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          height: 0.9,
                                          fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${getL10(context).vocationalTrainingAcademy} ${getL10(context).academy}",
                                  style: getThemeData(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          // height: 0.9,
                                          ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Spacer(),
                if (!widget.isUserGuest)
                  RowItemOfDrawer(
                    title: getL10(context).trainees,
                    imagePath: "assets/images/teachers_ic.svg",
                  ).onTap(() {
                    Navigator.of(context).push(routeToPage(const TeachersPage(
                      mainPage: false,
                    )));
                  }),
                if (!widget.isUserGuest)
                  RowItemOfDrawer(
                    title: getL10(context).trainingProvissions,
                    imagePath: "assets/images/courses_ic.svg",
                  ).onTap(() {
                    Navigator.of(context)
                        .popAndPushNamed(CourseCategoriesPage.name);
                  }),
                RowItemOfDrawer(
                  title: getL10(context).news,
                  imagePath: "assets/images/news_ic.svg",
                ).onTap(
                  () {
                    Navigator.of(context).push(routeToPage(const NewsPage()));
                  },
                ),
                RowItemOfDrawer(
                  title: getL10(context).callus,
                  imagePath: "assets/images/callus_ic.svg",
                ).onTap(
                  () {
                    Navigator.of(context).push(routeToPage( ContactUs()));
                  },
                ),
                if ((!widget.isUserGuest) && loggedUser!.isAdmin)
                  RowItemOfDrawer(
                    title: getL10(context).openAdminPanel,
                    imagePath: "assets/images/admin_ic.svg",
                  ).onTap(
                    () {
                      Navigator.of(context).push(
                        routeToPage(
                          AppWebView(
                            // "https://manpoweracademy.nitg-eg.com/admin/search.php?token=${loggedUser!.token}",
                            "https://manpoweracademy.nitg-eg.com/course/edit.php?id=13&token=${loggedUser!.token}",
                            getL10(context).openAdminPanel,
                          ),
                        ),
                      );
                    },
                  ),
                const Spacer(),
                if (!widget.isUserGuest)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                        ),
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout,
                          ),
                        ),
                        onPressed: () async {
                          // During logout
                          // GetIt.I.unregister<HomeController>();

                          await SharedPreferencesService.instance.clear();

                          Navigator.of(context).pushAndRemoveUntil(
                              routeToPage(const SplashPage()),
                              (route) => false);
                        },
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                          ),
                          child: Text(getL10(context).logout),
                        ),
                      ),
                      getWidthSpace(10)
                    ],
                  ),
                if (widget.isUserGuest)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.logout,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        },
                        label: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                          ),
                          child: Text(getL10(context).login),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RowItemOfDrawer extends StatelessWidget {
  const RowItemOfDrawer({
    super.key,
    required this.imagePath,
    required this.title,
  });

  final String imagePath, title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(),
        SvgPicture.asset(
          imagePath,
          height: 30,
          colorFilter: ColorFilter.mode(
            getThemeData(context).colorScheme.onBackground,
            BlendMode.srcIn,
          ),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: kPrimaryColor,
            disabledForegroundColor: kOnPrimary,
            /* minimumSize: Size(
              getScreenSize(context).width * 0.4,
              0,
            ),
            maximumSize: Size(
              getScreenSize(context).width * 0.4,
              40,
            ),*/
            fixedSize: Size(
              getScreenSize(context).width * 0.4,
              30,
            ),
          ),
          child: Text(
            title,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

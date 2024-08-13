// import 'package:al_mariey/app/core/data/models/category.dart';
// import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
// import 'package:al_mariey/app/core/global_used_widgets/general_use.dart';
// import 'package:al_mariey/app/core/themes/colors.dart';
// import 'package:al_mariey/app/modules/home_page/home_controller.dart';
// import 'package:al_mariey/app/utils/helper_funcs.dart';
// import 'package:al_mariey/app/widgets/app_bars.dart';
// import 'package:al_mariey/app/widgets/texts.dart';
// import 'package:al_mariey/main.dart';
// import 'package:flutter/material.dart';
// import '../../core/data/models/course.dart';
// import '../../utils/routing_utils.dart';
// import '../course_profile/course_profile_page.dart';
//
// class YearsOfStage extends StatelessWidget {
//   const YearsOfStage({
//     super.key,
//     required this.courseCategory,
//   });
//   final AcademicStage courseCategory;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: getScreenHeight(context),
//         width: getScreenWidth(context),
//         child: Column(
//           children: [
//             const NormalAppBar(
//               title: "Academic years",
//             ),
//             Expanded(
//               child: GridView.builder(
//                 itemCount: courseCategory.years.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 5.0,
//                   // childAspectRatio: 15 / 12
//                   // mainAxisSpacing: 8.0,
//                   mainAxisExtent: 150.0,
//                 ),
//                 itemBuilder: (context, index) => Container(
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 10,
//                   ),
//                   child: Column(
//                     children: [
//                       Image.network(
//                         courseCategory.years[index].categoryInstance.image,
//                         width: 90,
//                         errorBuilder: (ee, obj, sta) => const Icon(Icons.error),
//                       ),
//                       ElevatedGradientButton(
//                         title:
//                             courseCategory.years[index].categoryInstance.name,
//                       )
//                     ],
//                   ).onTap(() {
//                     if (getIt<HomeController>().getIsUserGuest()) {
//                       displayYouNeedLogin(context);
//                     } else {
//                       Navigator.of(context).push(
//                         routeToPage(
//                           CoursesOfYear(
//                             courseCategory: courseCategory.years[index],
//                           ),
//                         ),
//                       );
//                     }
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ElevatedGradientButton extends StatelessWidget {
//   const ElevatedGradientButton({
//     super.key,
//     required this.title,
//   });
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 5,
//       ),
//       decoration: BoxDecoration(
//         color: kSecondaryColor,
//         gradient:  LinearGradient(
//           colors: [
//             kPrimaryColor,
//             kSecondaryColor,
//           ],
//           end: Alignment.centerRight,
//           begin: Alignment.centerLeft,
//         ),
//         borderRadius: BorderRadius.circular(
//           12,
//         ),
//       ),
//       child: getNormalText(
//         truncateString(
//           title,
//           15,
//         ),
//         context,
//         weight: FontWeight.bold,
//         color: kOnPrimary,
//       ),
//     );
//   }
// }
//
// class CoursesOfYear extends StatelessWidget {
//   const CoursesOfYear({
//     super.key,
//     required this.courseCategory,
//   });
//   final AcademicYear courseCategory;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: getScreenHeight(context),
//         width: getScreenWidth(context),
//         child: Column(
//           children: [
//             NormalAppBar(
//               title: getL10(context).courses,
//             ),
//             Expanded(
//               child: GridView.builder(
//                   itemCount: courseCategory.courses.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 8.0,
//                       childAspectRatio: 9 / 10
//                       // childAspectRatio: 15 / 11
//                       // mainAxisSpacing: 8.0,
//                       // mainAxisExtent: 1.0,
//                       ),
//                   itemBuilder: (context, index) => CourseItemOfYear(
//                         e: courseCategory.courses[index],
//                       )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CourseItemOfYear extends StatelessWidget {
//   const CourseItemOfYear({super.key, required this.e});
//   final Course e;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: 120,
//       width: 150,
//       margin: const EdgeInsets.all(8),
//       child: Column(
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: 100,
//                 // height: 80,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 5,
//                 ),
//                 margin: const EdgeInsets.symmetric(
//                   vertical: 1,
//                   horizontal: 8,
//                 ),
//                 child: Image.network(
//                   e.imageUrl,
//                   width: 150,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.cyan,
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 8,
//                   vertical: 5,
//                 ),
//                 child: getNormalText(
//                   truncateString(e.fullName, 25),
//                   context,
//                   color: kOnPrimary,
//                   weight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ).onTap(() {
//             Navigator.of(context).push(
//               routeToPage(
//                 CourseProfilePage(
//                   course: e,
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

import 'package:al_mariey/app/core/constants_and_enums/static_data.dart';
import 'package:al_mariey/app/core/data/models/course_details.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/course_profile/course_profile_controller.dart';
import 'package:al_mariey/app/modules/open_pdf/open_pdf.dart';
import 'package:al_mariey/app/modules/web_view/view/web_view.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/utils/routing_utils.dart';
import 'package:al_mariey/app/widgets/messages.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ModuleItem extends StatelessWidget {
  const ModuleItem({super.key, required this.module});

  final Module module;

  @override
  Widget build(BuildContext context) {
    print( module.modicon);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(5),
      height: getScreenHeight(context)*0.05,
       width: getScreenWidth(context),   
          color: HexColor('#D9D9D9'),
      child: Row(
        children: [
          Image.network(
            module.modicon ?? StaticData.imagePlaceHolder,
            errorBuilder: (ee,rr,cc)=> Icon(Icons.error,color:HexColor('#45474B'),size: 28),
            width: 30,
            height: 30,
          ),
          /* Icon(
            getIcon(),
          ),*/
          getWidthSpace(10),
          getNormalText(
            module.name,
            context,
            color: HexColor('#45474B'),
            family: 'Bold',size: 14
          ),
        ],
      ),
    ).onTap(() {
      final controller =
          Provider.of<CourseProfileController>(context, listen: false);

      // if (controller.isUserTeacherOfThisCourseOrAdminOrStudentSubscribed()) {
       /* if (module.modname == "resource") {
          final token = controller.getLoggedUser().token;
          // print("////${module.url}&token=$token");
          Navigator.push(
            context,
            routeToPage(
              OpenPdfPage(
                fileUrl: "${module.fileDetails!.fileurl}&token=$token",
                title: module.name,
              ),
            ),
          );
        } else */{
          final token = controller.getLoggedUser().token;
          Navigator.push(
            context,
            routeToPage((module.fileDetails!=null && module.fileDetails!.type!=null && module.fileDetails!.type=='file')?
            OpenPdfPage(fileUrl:"${module.fileDetails!.filepath!}&token=$token" ,
            title: module.name): AppWebView(
                "${module.url}&token=$token",
                module.name)
            ) );
        }
      // } else {
      //   showSnackBar(
      //     context,
      //     getL10(context).subscribeToShowCourseContent,
      //     color: kSecondaryColor,
      //   );
      // }
    });
  }

  IconData? getIcon() {
    if (module.modname == "resource") {
      return Icons.picture_as_pdf_outlined;
    } else if (module.modname == "page")
      return Icons.play_circle;
    else if (module.modname == "quiz")
      return Icons.quiz_outlined;
    else
      return Icons.web;
  }
}

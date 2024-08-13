import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/data/models/course_details.dart';
import '../core/themes/colors.dart';
import '../modules/course_profile/course_profile_controller.dart';
import '../utils/helper_funcs.dart';

class OnlineSessionButton extends StatefulWidget {
  const OnlineSessionButton({super.key});

  @override
  State<OnlineSessionButton> createState() => _OnlineSessionButton();
}

class _OnlineSessionButton extends State<OnlineSessionButton> {
  bool isTherePromo = false;
  late final CourseDetails details;

  @override
  void initState() {
    details = Provider.of<CourseProfileController>(context, listen: false)
        .courseDetails;
    if (details.otherFields.online_url != null) {
      isTherePromo = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getThemeData(context).colorScheme.background,
      // height: getScreenSize(context).height * 0.3,
      width: getScreenSize(context).width,
      child: Builder(
        builder: (context) {
          if (isTherePromo) {
            return Container(
              height: 200,
              width: getScreenWidth(context),
              decoration: BoxDecoration(
                color: Colors.white,
               border: Border(bottom: BorderSide(color: HexColor('#D9D9D9'),width: 5))
              ),
              child: Column(
                children: [
                  const Spacer(),
                   ImageIcon(
                    AssetImage('assets/images/video.png'),
                    size: 100,
                    color: HexColor('#45474B'),
                  ),
                  const Spacer(),
                ],
              ),
            ).onTap(() {
              launchUrl(
                Uri.parse(details.otherFields.online_url!),
                mode: LaunchMode.externalApplication,
              );
            });
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

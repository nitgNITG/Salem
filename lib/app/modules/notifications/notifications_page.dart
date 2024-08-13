import 'package:al_mariey/app/modules/notifications/notifications_controller.dart';
import 'package:al_mariey/app/modules/web_view/view/web_view.dart';
import 'package:flutter/material.dart';

import '../../utils/helper_funcs.dart';
import '../base/base_view.dart';

class NotificationsPAge extends StatefulWidget {
  const NotificationsPAge({super.key});

  @override
  State<NotificationsPAge> createState() => _NotificationsPAgeState();
}

class _NotificationsPAgeState extends State<NotificationsPAge> {
  late final NotificationsController controller;

  @override
  void initState() {
    super.initState();
    controller = NotificationsController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsController>(
      injectedObject: controller,
      child: SizedBox(
          height: getScreenSize(context).height,
          width: getScreenSize(context).width,
          child: AppWebView(
            "https://manpoweracademy.nitg-eg.com/message/output/popup/notifications.php?token=${controller.getLoggedUser().token}",
            getL10(context).notifications,
          )

          /* Column(
          children: [
            NormalAppBar(
              title: getL10(context).notifications,
              icon: "assets/images/notfs_bottom_bar_ic.svg",
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(getL10(context).deleteAll),
                    style: ButtonStyle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: controller.notificationsList
                    .map(
                      (e) => ListTile(
                        title: Text(e["title"]!),
                        subtitle: Text(e["time"]!),
                        trailing: Icon(
                          Icons.more_horiz_outlined,
                          color: getThemeData(context).colorScheme.onBackground,
                        ),
                      ),
                    )
                    .toList(),
              )),
            )
          ],
        ),
     */

          ),
    );
  }
}

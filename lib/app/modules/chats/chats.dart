import 'package:al_mariey/app/modules/chats/chats_controller.dart';
import 'package:al_mariey/app/modules/web_view/view/web_view.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';

import '../base/base_view.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final ChatsController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = ChatsController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ChatsController>(
      injectedObject: controller,
      child: SizedBox(
        height: getScreenSize(context).height,
        width: getScreenSize(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /*   NormalAppBar(
                title: getL10(context).chats,
                icon: "assets/images/chats_bottom_bar_ic.svg"), */
            Expanded(
                child: AppWebView(
              "https://manpoweracademy.nitg-eg.com/message/index.php?token=${controller.getLoggedUser().token!}",
              getL10(context).chats,
            )

                /*         ListView.builder(
                // physics: const BouncingScrollPhysics(),
                itemCount: controller.chatsList.length,
                itemBuilder: (context, index) => ListTile(
                  tileColor: Colors.amber,
                  leading: Container(
                    width: 50,
                    // height: 30,
                    decoration: BoxDecoration(
                      color: getRandomQuietColor(),
                      shape: BoxShape.circle,
                    ),
                  ),
                  title: Text(controller.chatsList[index]["name"]!),
                  subtitle: Text(controller.chatsList[index]["message"]!),
                  trailing: Text(
                    controller.chatsList[index]["time"]!,
                    style: TextStyle(
                      color: getThemeData(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.7),
                    ),
                  ),
                ),
              ),
         */
                )
          ],
        ),
      ),
    );
  }
}

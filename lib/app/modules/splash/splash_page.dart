import 'package:al_mariey/app/modules/splash/splash_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = SplashController();
  @override
  void initState() {
    super.initState();
    controller.navigate(context);
  }

  requestNotificationPermission() {
    // FirebaseMessaging.instance.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox.expand(
        child: Image.asset(
              "assets/images/SPLASH.png",
              fit: BoxFit.cover,
              width: getScreenSize(context).width,
              height: getScreenSize(context).height,
            )
      );
    });
  }
}

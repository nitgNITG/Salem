import 'dart:async';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:al_mariey/app/modules/home/home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../core/data/shared_preferences/shared_preferences_keys.dart';
import '../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../utils/routing_utils.dart';

class SplashController extends BaseController {
  void navigate(context) async {
    final connectivtyResult = await Connectivity().checkConnectivity();
    Timer(
      const Duration(seconds: 3),
      () {
        final str = SharedPreferencesService.instance
            .getString(SharedPreferencesKeys.loggedUser);
print(str);
print(getIsUserGuest());
        if (getIsUserGuest() || str == null) {
          Navigator.of(context).pushReplacement(
            routeToPage(
                HomeMainParentPage(connectivityResult: connectivtyResult)),
          );
        } else {
          Navigator.of(context).pushReplacement(
            routeToPage(
              HomeMainParentPage(connectivityResult: connectivtyResult),
            ),
          );
        }
      },
    );
  }
}

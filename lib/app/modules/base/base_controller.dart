import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/data/models/logged_user.dart';
import 'package:al_mariey/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:al_mariey/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:al_mariey/app/widgets/messages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../utils/helper_funcs.dart';

class BaseController extends ChangeNotifier {
  // AppViewState? _state;

  final ValueNotifier<AppViewState> state =
  ValueNotifier<AppViewState>(AppViewState.idle);
  BuildContext? context;
  LoggedUser? loggedUer;

  LoggedUser getLoggedUser() {
    final jsonString = SharedPreferencesService.instance
        .getString(SharedPreferencesKeys.loggedUser);
    if (jsonString != null) loggedUer = LoggedUser.fromString(jsonString);
    return loggedUer!;
  }

  /*
  AppViewState getViewState() {
    return _state ?? AppViewState.idle;
  }
 */

  changeViewState(AppViewState state2) {
    state.value = state2;
    // notifyListeners();
  }

  bool getIsUserGuest() {
    return SharedPreferencesService.instance
        .getBool(SharedPreferencesKeys.userTypeIsGust) ??
        true;
  }

  Future<bool> setIsUserGuest()  async {
    await SharedPreferencesService.instance
        .setBool(SharedPreferencesKeys.userTypeIsGust,true);
    return true;
  }

  onError(error, context) {
    if (error is DioException) {
      showSnackBar(
          context!, getL10(context).checkTheInternetConnectionAndTryAgain);
    } else {
      showSnackBar(context!, error.toString());
    }
  }
}
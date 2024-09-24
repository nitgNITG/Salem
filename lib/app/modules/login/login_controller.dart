import 'dart:convert';

import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/core/data/api/ApiCall.dart';
import 'package:al_mariey/app/core/data/shared_preferences/shared_preferences_keys.dart';
import 'package:al_mariey/app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:al_mariey/app/widgets/messages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/models/logged_user.dart';
import '../../core/data/shared_preferences/helper_funcs.dart';
import '../../utils/routing_utils.dart';
import '../home/home.dart';
import 'package:http/http.dart' as http;

class LoginController extends BaseController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ValueNotifier<String> allRightsText = ValueNotifier("");
  String allRightsCompanyName = "";
  String allRightsYear = "";
  String allRightsCompanyNameEnglish = "";
  String allRightsLink = "";

  void login() async {
    changeViewState(AppViewState.busy);

    try {
      https: //salem-mar3y.com/salem_apis/signleteacher/apis.php
      const deviceId = "123";
      final respose = await CallApi.getRequest(
          "https://salem-mar3y.com/salem_apis/signleteacher/apis.php?function=login&email=${emailController.text}&password=${passwordController.text}");
      print(respose);

      if (respose["status"] == "success") {
        await SharedPreferencesService.instance
            .setBool(SharedPreferencesKeys.userTypeIsGust, false);

        await saveToSharedPref(respose["data"]);


          await saveToSharedPref2(respose["data"]);


        changeViewState(AppViewState.idle);

        await Future.delayed(const Duration(milliseconds: 200));
        Navigator.of(context!).pushAndRemoveUntil(
          routeToPage(
            HomeMainParentPage(),
          ),
          (c) => false,
        );
      } else {
        changeViewState(AppViewState.idle);
        showSnackBar(context!, respose["error"]);
      }
    } catch (e) {
      changeViewState(AppViewState.idle);

      onError(e, context);
    }

    // (_)=>false
    // (route) => false,
  }

  getAllRightReserverved() async {
    try {
      final response = await CallApi.getRequest(
          "https://salem-mar3y.com/salem_apis/signleteacher/apis.php?function=property_rights");

      if (response["data"] != null) {
        allRightsText.value = (response['data'].first['text']);
        allRightsCompanyName = (response['data'].first['company']);
        allRightsYear = (response['data'].first['year']);
        allRightsCompanyNameEnglish = (response['data'].first['text2']);
        allRightsLink = (response['data'].first['link']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void loginAsGuest(context) {
    SharedPreferencesService.instance.clear();

    SharedPreferencesService.instance
        .setBool(SharedPreferencesKeys.userTypeIsGust, true);

    Navigator.of(context).push(
      routeToPage(HomeMainParentPage()),
      // (route) => false,
    );

  }
  Future<void> saveToSharedPref2(Map<String, dynamic> userData) async {
    // Example of how to save user data
    final prefs = await SharedPreferences.getInstance();

    // Assuming your userData contains fields like id, token, etc.
    prefs.setInt('userId', userData['id']);
    prefs.setString('firstName', userData['firstName']);
    prefs.setString('lastName', userData['lastName']);
    prefs.setString('email', userData['email']);
    prefs.setString('token', userData['token']);
    prefs.setString('have_wallet', userData['have_wallet'].toString());
    prefs.setString('wallet_uuid', userData['wallet_uuid']);

    // Print the values being saved
    print('Saved to Shared Preferences:');
    print('User ID: ${userData['id']}');
    print('First Name: ${userData['firstName']}');
    print('Last Name: ${userData['lastName']}');
    print('Email: ${userData['email']}');
    print('Token: ${userData['token']}');
    print('have_wallet: ${userData['have_wallet'].toString()}');
    print('wallet_uuid: ${userData['wallet_uuid']}');
  }
}

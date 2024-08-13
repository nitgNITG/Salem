import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/ContactModel.dart';

class PrivacyController extends BaseController {
  late PrivacyModel contact;


  Future<void> Privacy() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "https://salem-mar3y.com/salem_apis/academyApi/json.php?function=about_block&block_name=cocoon_custom_html",
      );

      if (response['state'] != 'fail') {
       contact=PrivacyModel.fromJson(response['data']);
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
    }
  }
}

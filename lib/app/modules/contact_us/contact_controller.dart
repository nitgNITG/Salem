import 'package:al_mariey/app/core/constants_and_enums/enums.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/ContactModel.dart';

class ContactController extends BaseController {
  List<Contact> contact=[];


  Future<void> ContactUs() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "https://salem-mar3y.com/salem_apis/academyApi/json.php?function=contact_us",
      );
      List<String> l= response['data'].keys.toList();
      if (response['status'] != 'fail') {
        contact.clear();
        for(int i=0;i<l.length;i++)
        contact.addAll([Contact.fromJson(response['data'][l[i]])]);
       print(contact );
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      debugPrint(e.toString());
      changeViewState(AppViewState.error);
    }
  }
}

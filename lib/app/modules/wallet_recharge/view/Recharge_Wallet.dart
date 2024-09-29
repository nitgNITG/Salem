
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/data/shared_preferences/sharedpreference_service.dart';
import '../../../core/themes/colors.dart';
import '../../../utils/helper_funcs.dart';
import '../../../utils/validators.dart';
import '../../../widgets/app_bars.dart';
import '../../../widgets/form_fields.dart';
import '../../web_view/view/web_view.dart';

  class web_recharge extends StatelessWidget {
    final  token;
  web_recharge({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AppWebView(
              "https://salem-mar3y.com/e-wallet/?lang=ar&token=$token",
              getL10(context).recharge,
            ),),

        ],
      ),

    );
  }
}

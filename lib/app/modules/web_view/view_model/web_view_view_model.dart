import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/constants_and_enums/enums.dart';

class AppWebViewViewModel extends BaseController {
  double progress = 0;

  WebViewController? webViewController;

  updateState() {
    changeViewState(AppViewState.idle);
  }

  Future<bool> onWillPop() async {
    if (await webViewController!.canGoBack()) {
      webViewController?.goBack();

      return false;
    } else {
      return true;
    }
  }

  String cssInjectionUrl =
      '';
  // https://academy2022.nitg-eg.com//mohamedmekhemar/academyApi/style/style.css
  String getJavaScriptInjection() {
    return """ javascript:(function() { 
    
      var link = document.createElement("link");
      link.type = "text/css";
      link.rel = "stylesheet";
      link.href = "$cssInjectionUrl";
      document.getElementsByTagName("head")[0].appendChild(link);
    
                var x = document.getElementsByClassName("inner_page_breadcrumb");
var y = document.getElementsByClassName("ccnHeader1");
var yMobile = document.getElementsByClassName("mobile-menu");
var z = document.getElementsByClassName("footer_one");
var a = document.getElementsByClassName("footer_middle_area");
var b = document.getElementsByClassName("footer_bottom_area");
var options = document.getElementById("ccnSettingsMenuContainer");

var dashboardTabs = document.getElementsByClassName("mobileNone");
var copyRightsBar = document.getElementsByClassName("copyright-widget");
var titleBar = document.getElementsByClassName("breadcrumb_widgets");
var learningPlansTitle = document.getElementsByClassName("ccnMdlHeading");

var options = document.getElementById("ccnSettingsMenuContainer");
if(options != null){options.style.display="none";}

var pageHeading = document.getElementById("page-heading-button");
if(pageHeading != null){pageHeading.style.display="none";}

var i;
var activityNav = document.getElementsByClassName("activity-navigation");
for (i = 0; i < activityNav .length; i++) {
    activityNav [i].style.display = "none";
}



for (i = 0; i < learningPlansTitle.length; i++) {
    learningPlansTitle[i].style.display = "none";
}
for (i = 0; i < titleBar.length; i++) {
    titleBar[i].style.display = "none";
}
for (i = 0; i < copyRightsBar.length; i++) {
    copyRightsBar[i].style.display = "none";
}
for (i = 0; i < dashboardTabs.length; i++) {
    dashboardTabs[i].style.display = "none";
}
for (i = 0; i < x.length; i++) {
    x[i].style.display = "none";
}
for (i = 0; i < y.length; i++) {
    y[i].style.display = "none";
}
for (i = 0; i < yMobile.length; i++) {
    yMobile[i].style.display = "none";
}
for (i = 0; i < z.length; i++) {
    z[i].style.display = "none";
}
for (i = 0; i < a.length; i++) {
    a[i].style.display = "none";
}
for (i = 0; i < b.length; i++) {
    b[i].style.display = "none";
}
                })()""";
  }
}

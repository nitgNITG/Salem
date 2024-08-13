import 'dart:io';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../../base/base_view.dart';
import '../view_model/web_view_view_model.dart';

class AppWebView extends StatefulWidget {
  final String url;
  final String title;
  final showAppBar;

  const AppWebView(this.url, this.title, {super.key, this.showAppBar = true});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late final AppWebViewViewModel appWebViewViewModel;

  @override
  void initState() {
    super.initState();

    appWebViewViewModel = AppWebViewViewModel();

    appWebViewViewModel.webViewController = WebViewController();

    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    appWebViewViewModel.webViewController =
        WebViewController.fromPlatformCreationParams(params);

// ···
    if (Platform.isAndroid) {
      AndroidWebViewController.enableDebugging(true);
      (appWebViewViewModel.webViewController!.platform
              as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
    }

    appWebViewViewModel.webViewController!
        .setJavaScriptMode(JavaScriptMode.unrestricted);
    String desktopUserAgent =
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36";
    appWebViewViewModel.webViewController!.setUserAgent(desktopUserAgent);
    appWebViewViewModel.webViewController!.loadRequest(Uri.parse(widget.url));

    appWebViewViewModel.webViewController!.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {
          print("///$url");
        },
        onPageFinished: (String url) {
          print("///$url");
          appWebViewViewModel.webViewController!.runJavaScriptReturningResult(
              appWebViewViewModel.getJavaScriptInjection()
          );
        },
        onWebResourceError: (WebResourceError error) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("///${widget.url}");
    return BaseView<AppWebViewViewModel>(
        injectedObject: appWebViewViewModel,
        child: Scaffold(
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, true);
              return true;
            },
            child: SizedBox(
              height: getScreenHeight(context),
              child: Column(
                children: [
                  if (widget.showAppBar) NormalAppBar(title: widget.title),
                  Expanded(
                    child: WebViewWidget(
                      controller: appWebViewViewModel.webViewController!,

                      /*

                      onLoadStop: (controller, url) async {

                        await controller.evaluateJavascript(

                            source: viewModel.getJavaScriptInjection());

                        await controller.injectCSSFileFromUrl(

                            urlFile: Uri.parse(viewModel.cssInjectionUrl));

                      },

                      initialOptions: InAppWebViewGroupOptions(

                        crossPlatform: InAppWebViewOptions(

                            allowUniversalAccessFromFileURLs: true,

                            allowFileAccessFromFileURLs: true,

                            useOnDownloadStart: true),*/

                      /*     android: AndroidInAppWebViewOptions(

                          domStorageEnabled: true,

                          databaseEnabled: true,

                          clearSessionCache: true,

                          thirdPartyCookiesEnabled: true,

                          allowFileAccess: true,

                          allowContentAccess: true,

                        ),*/
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:al_mariey/app/modules/global_used_widgets/widget_methods.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global_used_widgets/no_internet.dart';

class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView(
      {required this.injectedObject,
      required this.child,
      super.key,
      this.connectivityResult});

  final T injectedObject;
  final ConnectivityResult? connectivityResult;
  final Widget child;

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.injectedObject,
      builder: (_, __) {
        return StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          initialData: widget.connectivityResult,
          builder: (context, snapShot) {
            if (snapShot.data != ConnectivityResult.none) {
              return Builder(builder: (context) {
                widget.injectedObject.context = context;
                return Stack(
                  children: [
                    getAppPostionedBackground(context),
                    widget.child,
                  ],
                );
              });
            } else {
              return const NoInternetConnection();
            }
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../core/constants_and_enums/enums.dart';

Widget getWidgetDependsInAppViewState(AppViewState state, Widget widget,
    {Function()? onClick}) {
  if (state == AppViewState.error) {
    return TryAgainErrorWidget(onclickTryAgain: onClick);
  } else if (state == AppViewState.busy) {
    return const BussyWidget();
  } else {
    return widget;
  }
}

class BussyWidget extends StatelessWidget {
  const BussyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/others/progress.json"),
      //                   assets/others/progress.json
    );
  }
}

class TryAgainErrorWidget extends StatelessWidget {
  const TryAgainErrorWidget({super.key, required this.onclickTryAgain});

  final Function()? onclickTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset("assets/others/error.json", height: 100),
          SizedBox(
            // width: getScreenWidth(context)/3,

            child: ElevatedButton(
              onPressed: onclickTryAgain,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0),
                child: Text("حدث خطأ حاول مجددا"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

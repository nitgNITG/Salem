import 'dart:ui';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/course_categories/trainig_centers/training_centers_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/data/models/course.dart';

class TrainingCentersPage extends StatelessWidget {
  TrainingCentersPage({
    super.key,
    required this.course,
  });

  late final TrainingCentersController? _controller;
  final Course course;
  TrainingCentersController getController() {
    try {
      _controller ??= TrainingCentersController();
    } catch (e) {
      _controller = TrainingCentersController();
      _controller!.getCenters(course.id);
    } finally {
      return _controller!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(
        injectedObject: getController(),
        child: SizedBox(
          height: getScreenHeight(context),
          child: Column(
            children: [
              NormalAppBar(title: getL10(context).trainigCenters),
              getHeightSpace(10),
              Row(
                children: [
                  getWidthSpace(10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 2.0,
                            sigmaY: 1.5,
                          ),
                          child: AlertDialog(
                            backgroundColor: kSecondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                getNormalText(getL10(context).notes, context,
                                    color: kOnPrimary,
                                    weight: FontWeight.bold,
                                    size: 22),
                                const Spacer(),
                                SvgPicture.asset("assets/images/close_ic.svg")
                                    .onTap(() {
                                  Navigator.pop(context);
                                })
                              ],
                            ),
                            titlePadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            actionsAlignment: MainAxisAlignment.start,
                            content: SizedBox(
                              height: getScreenHeight(context) * 0.5,
                              child: SingleChildScrollView(
                                child: getNormalText(
                                  getController().notes + getController().notes,
                                  context,
                                  color: kOnPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        barrierDismissible: true,
                        barrierColor: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.15),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      child: Text(
                        getL10(context).notes,
                      ),
                    ),
                  ),
                ],
              ),
              getHeightSpace(10),
              ValueListenableBuilder(
                  valueListenable: getController().state,
                  builder: (context, state, child) {
                    return getWidgetDependsInAppViewState(
                        state,
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [],
                            ),
                          ),
                        ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

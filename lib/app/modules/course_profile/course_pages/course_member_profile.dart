
import 'package:al_mariey/app/core/data/default_values.dart';
import 'package:al_mariey/app/core/data/models/course_member.dart';
import 'package:al_mariey/app/core/global_used_widgets/circle_image_container.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../utils/helper_funcs.dart';
import '../../../widgets/app_bars.dart';
import '../../../widgets/texts.dart';
import '../../global_used_widgets/widget_methods.dart';

class CourseMemberProfile extends StatefulWidget {
  const CourseMemberProfile(this.courseMember, {super.key});

  final CourseMember courseMember;

  @override
  State<CourseMemberProfile> createState() => _CourseMemberProfileState();
}

class _CourseMemberProfileState extends State<CourseMemberProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getScreenSize(context).height,
      width: getScreenSize(context).width,
      child: Scaffold(
        body: Container(
          height: getScreenSize(context).height,
          width: getScreenSize(context).width,
          color: getThemeData(context).colorScheme.background,
          child: Builder(builder: (context) {
            return Stack(
              children: [
                getAppPostionedBackground(context),
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: getScreenSize(context).height * 0.25,
                          child: Container(
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xFF042F53).withOpacity(0.8),
                                  const Color(
                                    0xE21269B3,
                                  ).withOpacity(0.8),
                                  const Color(
                                    0xE21269B3,
                                  ).withOpacity(0.8),
                                ],
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                NormalAppBar(
                                  title: getL10(context).profile,
                                  obacity: 0.1,
                                ),
                                const Spacer(),
                                Builder(builder: (context) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      getWidthSpace(
                                          getScreenWidth(context) * 0.2),
                                      getCircleImageContainer(
                                          widget.courseMember.userImage ??
                                              DefaultValues.image),
                                      getWidthSpace(10),
                                      Column(
                                        children: [
                                          getNormalText(
                                            "${widget.courseMember.fullName}",
                                            context,
                                            color: kOnPrimary,
                                            weight: FontWeight.bold,
                                          ),
                                          getNormalText(
                                            widget.courseMember.lastAccess,
                                            context,
                                            color: kOnPrimary,
                                            weight: FontWeight.bold,
                                          )
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),

                          /// this heights is come from top they are of the stacks
                          width: getScreenWidth(context),
                          height: getScreenHeight(context) * 0.75,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getHeightSpace(
                                    (getScreenSize(context).height * 0.03),
                                  ),

                                  /// the title data and the edit icon
                                  Row(
                                    children: [
                                      const Spacer(),
                                      getTitleText(
                                        getL10(context).personalData,
                                        context,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),

                                  getHeightSpace(10),
                                  getRowItemProfile(
                                    context,
                                    getL10(context).name,
                                    widget.courseMember.fullName,
                                  ),

                                  getHeightSpace(20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// this is the my courses under the card
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget getRowItemProfile(BuildContext context, title, value) {
    return Column(
      children: [
        getHeightSpace(10),
        getNormalText(title + " / " + value, context, weight: FontWeight.bold),
      ],
    );
  }
}

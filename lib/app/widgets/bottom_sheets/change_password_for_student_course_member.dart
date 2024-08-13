import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../core/constants_and_enums/static_data.dart';
import '../../core/data/api/ApiCall.dart';
import '../../core/data/models/course_member.dart';
import '../../utils/helper_funcs.dart';
import '../form_fields.dart';
import '../messages.dart';

class ChangeCourseMemberPasswordBottomSheet extends StatefulWidget {
  const ChangeCourseMemberPasswordBottomSheet(this.member, {super.key});

  final CourseMember member;

  @override
  State<ChangeCourseMemberPasswordBottomSheet> createState() =>
      _ChangeCourseMemberPasswordBottomSheetState();
}

class _ChangeCourseMemberPasswordBottomSheetState
    extends State<ChangeCourseMemberPasswordBottomSheet> {
  final TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  Color barrierBackground = Colors.black.withOpacity(0.8);
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (mounted) focusNode.requestFocus();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Form(key: _key,child: Column(
      children: [
        Expanded(
            child: InkWell(
          onTap: () async {
            setState(() {
              barrierBackground = Colors.black.withOpacity(0);
            });
            await Future.delayed(const Duration(microseconds: 100));
            // ignore: use_build_context_synchronously
            Navigator.of(context).pop();
          },
          child: Container(
            color: barrierBackground,
          ),
        )),
        Container(
          color: HexColor('#45474B'),
          child: Column(
            children: [
              getHeightSpace(15),
              SizedBox(
                width: getScreenWidth(context) * 0.8,
                child:  PasswordFormField(
                  bodyHeight: 40,
                  maxLength: 20,
                  title: getL10(context).newPassword,
                  controller: textEditingController,
                  validatetor: (value) {
                    if ((value?.isNotEmpty ?? false) &&
                        value!.length > 5) {
                      return null;
                    }
                    return getL10(context)
                        .pleaseEnterValidPaswordLengthMustBeMoreThan4;
                  },
                ),

                // TextFormFieldWidget(
                //   title: getL10(context).newPassword,
                //   controller: textEditingController,
                //   focusNode: focusNode,
                //   heightOfBoty: 35,
                //   hint: '......',
                //   titleColor: HexColor('#FFFFFF'),
                //   fillColor: Colors.white,
                // ),
              ),
              getHeightSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: HexColor('#F4CE14'),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                      child: Text(getL10(context).cancel,style: TextStyle(color: Colors.white,fontFamily: 'Bold',fontSize: 16))),
                  ElevatedButton(
                    onPressed: () async {
                      if(_key.currentState!.validate()){
                      try {
                        FocusManager.instance.primaryFocus?.unfocus();
                        final response = await CallApi.getRequest(
                            "${StaticData.baseUrl}/academyApi/json.php?function=changeUserPassword&new_password=${textEditingController.text.toString()}&user_id=${widget.member.id}");
                        if (response['data'] != null) {
                          Navigator.of(context).pop();
                          await Future.delayed(
                            const Duration(
                              milliseconds: 200,
                            ),
                          );

                          showSnackBar(
                            context,
                            getL10(context).updatedSuccesfull,
                            color: HexColor('#008170'),
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                          context,
                          getL10(context).tryAgain,
                        );
                      }
                       }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: HexColor('#008170'),shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                    child: Text(getL10(context).save,style: TextStyle(color: Colors.white,fontFamily: 'Bold',fontSize: 16)),
                  ),
                ],
              ),
              getHeightSpace(10)
            ],
          ),
        ),
      ],
    )
    );
  }
}

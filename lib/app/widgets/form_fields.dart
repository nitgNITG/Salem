import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../global_providers/theme_provider.dart';
import '../core/themes/colors.dart';
import '../core/themes/helper_funtions.dart';
import 'texts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    required this.title,
    super.key,
    this.fillColor,
    this.icon,
    this.titleColor,
    this.validatetor,
    this.textInputType,
    this.controller,
    this.maxLength,
    this.enabled=true,
    this.showCounter = false,
    this.heightOfBoty,
    this.formatters,
    this.focusNode, this.hint,this.suffix
  });

  final FocusNode? focusNode;
  final bool showCounter;
  final String title;
  final String? hint;
  final bool?enabled;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final Icon? icon;
  final Widget? suffix;
  final TextInputType? textInputType;
  final String? Function(String?)? validatetor;
  final int? maxLength;
  final List<TextInputFormatter>? formatters;
  final double? heightOfBoty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: getNormalText(
              title,
              context,
              family: 'Medium',
              size: 12,
              color: titleColor ?? kOnPrimary,
              weight: FontWeight.bold,
            ),
          ),
        getHeightSpace(3),
        Builder(builder: (context) {
          return SizedBox(
            height: showCounter ? heightOfBoty ?? 0 + 30 : heightOfBoty!*2,
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              focusNode: focusNode,
              enabled: enabled,
              inputFormatters: formatters,
              buildCounter: showCounter
                  ? (
                      context, {
                      currentLength = 0,
                      isFocused = false,
                      maxLength,
                    }) =>
                      isFocused ? Text(currentLength.toString()) : null
                  : null,
              maxLength: maxLength,
              style: getThemeData(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Bold',
                    fontSize: 14,
                    color: kBlPrimary), decoration:
                  getDecoration(getThemeData(context).inputDecorationTheme)
                      .copyWith(
                    counter: Text(''),
                    hintText:hint?? 'example@gmail.com',
                // Fix input field height
                counterStyle: const TextStyle(height: 0.5, color: Colors.white),
                fillColor: fillColor,
                      errorMaxLines: 1,
                      hintStyle: TextStyle(fontSize: 12,color: HexColor('#767676'),fontFamily: 'Medium'),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                errorStyle:  TextStyle(
                    color: Colors.red.shade300,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.clip),
                prefixIcon: icon,
                    suffix: suffix
              ),
              validator: validatetor,
              maxLines: 1,
            ),
          );
        }),
      ],
    );
  }
}

class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,
      {TextSelection? selection}) {
    if (newValue.text.contains(' ')) {
      final newText = newValue.text.replaceAll(' ', '');
      return newValue.copyWith(text: newText, selection: selection);
    } else {
      return newValue;
    }
  }
}

class MultilineTextInputWithScrollArrows extends FormField<String> {
  MultilineTextInputWithScrollArrows({
    super.key,
    required TextEditingController controller,
    required InputDecoration decoration,
  }) : super(
          initialValue: "",
          builder: (context) {
            return Container(
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: decoration.copyWith(
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_upward),
                        onPressed: () {
                          if (controller.selection.start > 0) {
                            controller.selection = TextSelection.collapsed(
                                offset: controller.selection.start - 1);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          if (controller.selection.end <
                              controller.text.length) {
                            controller.selection = TextSelection.collapsed(
                                offset: controller.selection.end + 1);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
}

Column getFormDropDownFieldWidget(
    BuildContext context, String title, List<Map<String, String>> list,
    {TextEditingController? controller, Color? titleColor, Color? fillColor}) {
  String? value = (controller?.text == null || controller!.text.isEmpty)
      ? null
      : controller.text;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title.isNotEmpty)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: getNormalText(
            title,
            context,
            size: 12,
            family: 'Medium',
            color: titleColor,
            weight: FontWeight.bold,
          ),
        ),
      DropdownButtonFormField<String>(
        items: list
            .map(
              (e) => DropdownMenuItem<String>(
                value: e['id'],
                child: Text(
                  e['name'].toString(),
                  style: TextStyle(
                    color: getThemeData(context).colorScheme.onBackground,
                  ),
                ),
              ),
            )
            .toList(),
        selectedItemBuilder: (vv) =>
            list.map((e) => Text(e['name'].toString())).toList(),
        onChanged: (Object? value) {
          value = value!;
          controller?.text = value.toString();
        },
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        style: getThemeData(context)
            .textTheme
            .displayMedium!
            .copyWith(fontWeight: FontWeight.bold, color: kSecondaryColor),
        iconSize: 50,
        iconEnabledColor: kPrimaryColor,
        value: value,
        decoration:
            getDecoration(getThemeData(context).inputDecorationTheme).copyWith(
          contentPadding: const EdgeInsets.symmetric(horizontal: 5),
          filled: true,
          fillColor: fillColor ?? _getBackgroundColor(context),
        ),
      ),
    ],
  );
}

_getBackgroundColor(context) {
  final themeMode =
      Provider.of<AppThemeProvider>(context, listen: false).getAppThemeMode();

  if (themeMode == ThemeMode.light) {
    return Colors.grey.withOpacity(0.7);
  } else {
    return Colors.white70;
  }
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    required this.title,
    super.key,
    this.fillColor,
    this.icon,
    this.titleColor,
    this.validatetor,
    this.textInputType,
    this.controller,
    this.maxLength = 15,
    this.bodyHeight,
  });

  final String title;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? titleColor;
  final Icon? icon;
  final TextInputType? textInputType;
  final String? Function(String?)? validatetor;
  final int maxLength;
  final double? bodyHeight;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool showPAssword = false;

  setShowPssword(bool show) {
    setState(() {
      showPAssword = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: getNormalText(
              widget.title,
              context,
              size: 12,
              family: 'Medium',
              color: widget.titleColor ?? kOnPrimary,
              weight: FontWeight.bold,
            ),
          ),
        getHeightSpace(1),
        SizedBox(
          height: widget.bodyHeight!*2,
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.textInputType,
            obscureText: !showPAssword,
            maxLength: widget.maxLength,

            style: getThemeData(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: kBlPrimary,
                ),
            decoration:
                getDecoration(getThemeData(context).inputDecorationTheme)
                    .copyWith(
                  hintText: '......',
                  hintStyle: TextStyle(fontSize: 12,color: HexColor('#767676'),fontFamily: 'Medium'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  errorBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  errorMaxLines: 1,
                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              counter: const SizedBox(),
              suffixIcon: (!showPAssword
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:  Icon(
                            Icons.visibility_off,
                            color: HexColor('#F4CE14'),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:  Icon(
                            Icons.visibility,
                            color: HexColor('#F4CE14'),
                          ),
                        ))
                  .onTap(() {
                setShowPssword(!showPAssword);
              }),
              fillColor: widget.fillColor,
              errorStyle:  TextStyle(
                color: Colors.red.shade300,
                fontWeight: FontWeight.bold,
              ),
              // counter: SizedBox(),
              prefixIcon: widget.icon,
              /*      suffixIcon: !(controller?.text.isEmpty ?? false)
                  ? null
                  : const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),*/
            ),
            validator: widget.validatetor,
          ),
        ),
      ],
    );
  }
}

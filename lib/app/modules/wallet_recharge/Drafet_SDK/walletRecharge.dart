// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hexcolor/hexcolor.dart';
//
// import '../../../core/constants_and_enums/enums.dart';
// import '../../../core/themes/colors.dart';
// import '../../../utils/helper_funcs.dart';
// import '../../../utils/validators.dart';
// import '../../../widgets/app_bars.dart';
// import '../../../widgets/form_fields.dart';
// import '../../../widgets/texts.dart';
// import '../model/PaymobService.dart';
//
// class Walletrecharge extends StatelessWidget {
//    Walletrecharge({super.key});
//
//   TextEditingController amount=TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           NormalAppBar(
//             title: getL10(context).recharge,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: TextFormFieldWidget(
//               title: getL10(context).email,
//               hint: getL10(context).amount ,
//               controller: amount,
//               titleColor: kOnPrimary,
//               formatters:  [
//                 FilteringTextInputFormatter.deny(r'[ ]'),
//               ],
//               heightOfBoty: 35,
//               validatetor: Validators(context).validateEmail,
//               showCounter: false,
//               // maxLength: 14,
//               textInputType: TextInputType.number,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: HexColor('#F4CE14'),
//                 maximumSize: Size(
//                   getScreenSize(context).width,
//                   50,
//                 ),
//                 minimumSize: Size(
//                   getScreenSize(context).width,
//                   50,
//                 ),
//                 textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//                 shape: ContinuousRectangleBorder(
//                     borderRadius: BorderRadius.circular(5)),
//               ),
//                 onPressed: () {
//                   // Convert the text to a double
//
//                 },
//               child:getNormalText(getL10(context).charge, context,
//                   color: HexColor('#45474B'), weight: FontWeight.bold, size: 16,family: 'Medium')      /// الخط بتاع الكلام اللي في زرار ال login
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

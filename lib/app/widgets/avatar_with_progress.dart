import 'package:flutter/material.dart';

import '../core/themes/colors.dart';
import '../utils/helper_funcs.dart';

class AvatarWithProgressBar extends StatelessWidget {
  final String imageUrl; // Provide the URL of the avatar image
  final double progress; // Progress value between 0 and 1
  final double width, height;

  const AvatarWithProgressBar({
    super.key,
    this.width = 80,
    this.height = 120,
    required this.imageUrl,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Rounded Avatar Image
        Container(
          width: width - 10,
          height: height - 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            /*      border: Border.all(
              color: getThemeData(context).colorScheme.onBackground,
              // Border color
              width: 4, // Border width
            ),*/
            /* boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // Shadow offset
              ),
            ],*/
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl, // Provide the URL of the avatar image here
              width: width,
              height: height,
              fit: BoxFit.fill,
              errorBuilder: (context, obj, stack) => Icon(Icons.error),
            ),
          ),
        ),

        // Progress Bar
        SizedBox(
          width: width, // Adjust the size as needed
          height: height,
          child: CircularProgressIndicator(
            value: progress,

            // Progress value between 0 and 1
            strokeWidth: 4,

            // Progress bar thickness
            valueColor: const AlwaysStoppedAnimation<Color>(
              kPrimaryColor,
            ),
            // Progress bar color
            backgroundColor: getThemeData(context)
                .colorScheme
                .onBackground, // Background color
          ),
        ),
      ],
    );
  }
}

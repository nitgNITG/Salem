import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:flutter/material.dart';

import '../../widgets/texts.dart';

class ImageAndText extends StatelessWidget {
  const ImageAndText({
    super.key,
    this.imageUrl,
    this.pageTextbody,
    this.pageTitle,
  });
  final String? pageTitle, imageUrl, pageTextbody;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            NormalAppBar(title: pageTitle ?? ""),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    getHeightSpace(10),
                    if (imageUrl != null)
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(imageUrl!),
                          ),
                        ),
                      ),
                    getHeightSpace(10),
                    if (pageTextbody != null)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 22),
                        child: getNormalText(pageTextbody, context,
                            weight: FontWeight.bold, align: TextAlign.justify),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

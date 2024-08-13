import 'package:al_mariey/app/core/data/models/news_model.dart';
import 'package:al_mariey/app/core/extensions_and_so_on/extesions.dart';
import 'package:al_mariey/app/core/themes/colors.dart';
import 'package:al_mariey/app/modules/base/base_view.dart';
import 'package:al_mariey/app/modules/news/news_controller.dart';
import 'package:al_mariey/app/utils/helper_funcs.dart';
import 'package:al_mariey/app/widgets/app_bars.dart';
import 'package:al_mariey/app/widgets/status_widgets.dart';
import 'package:al_mariey/app/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final NewsController controller;

  @override
  void initState() {
    super.initState();
    controller = NewsController();
    controller.getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView(
        injectedObject: controller,
        child: Column(
          children: [
            NormalAppBar(
              title: getL10(context).news,
              icon: "assets/images/news_ic.svg",
            ),
            SizedBox(
              height: getScreenHeight(context) -
                  kToolbarHeight -
                  (MediaQuery.paddingOf(context).top),
              child: BaseView<NewsController>(
                injectedObject: controller,
                child: ValueListenableBuilder(
                  valueListenable: controller.state,
                  builder: (context, state, widget) {
                    return getWidgetDependsInAppViewState(
                      state,
                      Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                                itemCount: controller.newsList.length,
                                controller: controller.pageController,
                                itemBuilder: (context, index) {
                                  return NewsTopItem(
                                    model: controller.newsList[index],
                                  );
                                }),
                          ),
                          SizedBox(
                            height: getScreenHeight(context) * 0.15,
                            width: getScreenWidth(context),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.newsList.length,
                              itemBuilder: (context, index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ImageWithGradientAndText(
                                  model: controller.newsList[index],
                                  width: getScreenWidth(context) * 0.4,
                                ),
                              ).onTap(() {
                                controller.pageController.jumpToPage(index);
                              }),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsTopItem extends StatelessWidget {
  const NewsTopItem({super.key, required this.model});

  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                getWidthSpace(5),
                SvgPicture.asset(
                  "assets/images/arrow_forward.svg",
                  colorFilter: ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                  // matchTextDirection: true,
                ).onTap(() {
                  Provider.of<NewsController>(context, listen: false)
                      .pageController
                      .nextPage(
                          duration: const Duration(microseconds: 100),
                          curve: Curves.linear);
                }),
                getWidthSpace(5),
                ImageWithGradientAndText(
                  model: model,
                  height: getScreenHeight(context) * 0.28,
                  width: getScreenWidth(context) * 0.82,
                ),
                getWidthSpace(5),
                SvgPicture.asset(
                  "assets/images/arrow_backward.svg",
                  colorFilter: ColorFilter.mode(
                    kPrimaryColor,
                    BlendMode.srcIn,
                  ),
                ).onTap(() {
                  Provider.of<NewsController>(context, listen: false)
                      .pageController
                      .previousPage(
                        duration: const Duration(microseconds: 100),
                        curve: Curves.linear,
                      );
                }),
                getWidthSpace(5),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: getNormalText(model.description, context,
                weight: FontWeight.bold, align: TextAlign.justify),
          ),
        ],
      ),
    );
  }
}

class ImageWithGradientAndText extends StatelessWidget {
  const ImageWithGradientAndText(
      {super.key, required this.model, required this.width, this.height});

  final double width;
  final double? height;
  final NewsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    model.image,
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kSecondaryColor,
                  kSecondaryColor.withOpacity(0.3),
                  kSecondaryColor.withOpacity(0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            width: width * 0.8,
            child: getNormalText(
              model.news,
              context,
              color: kOnPrimary,
              weight: FontWeight.bold,
              size: height == null ? 8 : 16,
            ),
          )
        ],
      ),
    );
  }
}

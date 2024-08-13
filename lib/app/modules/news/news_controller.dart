import 'package:al_mariey/app/core/data/models/news_model.dart';
import 'package:al_mariey/app/modules/base/base_controller.dart';
import 'package:flutter/material.dart';

import '../../core/constants_and_enums/enums.dart';
import '../../core/data/api/ApiCall.dart';

class NewsController extends BaseController {
  List<NewsModel> newsList = [];

  PageController pageController = PageController();

  getNewsList() async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
          "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/academyApi/json.php?function=get_all_news");
      if (response['status'] != 'fail') {
        newsList = (response['data'] as List)
            .map((e) {
              return NewsModel.fromJson(e);
            })
            .cast<NewsModel>()
            .toList();
        changeViewState(AppViewState.idle);
      }
    } catch (e) {
      changeViewState(AppViewState.error);
    }
  }
}

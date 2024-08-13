import 'package:al_mariey/app/modules/base/base_controller.dart';

import '../../../core/constants_and_enums/enums.dart';
import '../../../core/data/api/ApiCall.dart';

class TrainingCentersController extends BaseController {
  String notes = "";
  getCenters(String id) async {
    try {
      changeViewState(AppViewState.busy);
      final response = await CallApi.getRequest(
        "https://manpoweracademy.nitg-eg.com/mohamedmekhemar/academyApi/json.php?function=training_centers&courseID=$id",
      );
      if (response['status'] != 'fail') {
        changeViewState(AppViewState.idle);

        notes = response['text'];
      }
    } catch (e) {
      changeViewState(AppViewState.error);
    }
  }
}

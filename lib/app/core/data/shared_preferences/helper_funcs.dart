import 'package:url_launcher/url_launcher.dart';

import '../models/logged_user.dart';
import 'shared_preferences_keys.dart';
import 'sharedpreference_service.dart';

saveToSharedPref(response) async {
  final loggedUser = LoggedUser.fromJson(response);

  await SharedPreferencesService.instance
      .setString(SharedPreferencesKeys.loggedUser, loggedUser.toString());
  return;

}

contactUsWhatsapp() {
  launchUrl(
    Uri.parse(
      "https://wa.me/+201067802534",
    ),
    mode: LaunchMode.externalApplication,
  );
}

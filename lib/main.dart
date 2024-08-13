import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'app/core/data/shared_preferences/sharedpreference_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'app/core/themes/light_theme.dart';
import 'app/modules/course_categories/course_categories_page.dart';
import 'app/modules/home_page/home_controller.dart';
import 'app/modules/splash/splash_page.dart';
import 'global_providers/localization_provider.dart';
import 'global_providers/theme_provider.dart';

/// created with respect by Mohammed Monem , mohamed essam in  nitg company
///0000

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
// }

void main() async {
  // Provider.debugCheckInvalidValueType = null;
  await initializeMain();
  runApp(const MyApp());
}

final getIt = GetIt.instance;

initializeMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // getIt.register<HomeController>(HomeController());
  getIt.registerSingleton<HomeController>(HomeController());
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalizationProvider>(
          create: (_) => LocalizationProvider(),
        ),
        ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => AppThemeProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'المرعي',
        themeMode: ThemeMode
            .light /* Provider.of<AppThemeProvider>(context).getAppThemeMode()*/,
        locale: const Locale('ar') /*Provider.of<LocalizationProvider>(context).getAppLocale()*/,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: const [
          Locale("ar"),
        ],
        theme: getLightThemeData(),
        routes: Map.from({
          CourseCategoriesPage.name: (context) => const CourseCategoriesPage(),
        }),
        home: Builder(builder: (context) {
          return const SplashPage();
        }),
      ),
    );
  }
}

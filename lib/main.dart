import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leader_app/bindings/general_bindings.dart';
import 'package:leader_app/data/repositorie/authentication/authentication_repository.dart';
import 'package:leader_app/routes/app_routes.dart';
import 'package:leader_app/features/start_screen.dart';
import 'package:leader_app/themes/theme_data_light.dart';
import 'package:leader_app/utils/theme/custom_themes/app_colors.dart';
import 'package:leader_app/utils/theme/theme.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

// import 'package:firebase_app_check/firebase_app_check.dart';

void main() async  {


  //  await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  // );

  ///**********WidgetsFlutterBinding.ensureInitialized();

  /// Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// -- Getx Local Storage
  await GetStorage.init();

  /// Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialize Firebase & Authentication Repository

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform) .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
//......
try {
  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider: AndroidProvider.debug,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
        // your preferred provider. Choose from:
        // 1. Debug provider
        // 2. Device Check provider
        // 3. App Attest provider
        // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: AppleProvider.appAttest,
  );
} catch (e) {
  if (e is FirebaseException && e.code == 'too-many-requests') {
    print('Rate limit exceeded. Please wait before retrying.');
    // Optionally, show a message to the user
  } else {
    print('App Check activation failed: $e');
  }
}  FlutterNativeSplash.remove();
FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);


///---------------
  runApp(const App());
}

class App extends StatelessWidget {
const App({super.key});

@override
Widget build(BuildContext context) {
return GetMaterialApp(
debugShowCheckedModeBanner: false,
debugShowMaterialGrid: false,
themeMode: ThemeMode.system,
theme:TAppTheme.lightTheme,
darkTheme: TAppTheme.darkTheme,
initialBinding: GeneralBindings(),
getPages: AppRoutes.pages,
/// Show Loader or Circular Progress Indicator meanwhile Authentication Repository is deciding to show relevant screen. 
home: const Scaffold(backgroundColor: TColors.PrimaryColor, body: Center(child: CircularProgressIndicator(color: Colors.white))),

);

}
}
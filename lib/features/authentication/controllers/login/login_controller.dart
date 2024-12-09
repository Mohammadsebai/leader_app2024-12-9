import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leader_app/utils/loaders/loaders.dart';
// import 'package:new_life/features/personalization/controllers/user_controller.dart';
// import 'package:new_life/utils/loaders/loaders.dart';

import '../../../../data/repositorie/authentication/authentication_repository.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class LoginController extends GetxController {
/// Variables
final rememberMe = false.obs;
final hidePassword = true.obs;
final localStorage = GetStorage();
final email = TextEditingController();
final password = TextEditingController();
GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
// final userController =Get.put(UserController());

@override
void onInit(){
email.text = localStorage.read('REMEMBER_ME_EMAIL')??'';
password.text = localStorage.read('REMEMBER_ME_PASSWORD')??'';
super.onInit();
}


/// -- Email and Password SignIn
Future<void> emailAndPasswordsignIn() async{
try{
// Start Loading
TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.handshake);

// ctheck Internet Connectivity
final isConnected = await NetworkManager.instance.isConnected();
if (!isConnected) {
TFullScreenLoader.stopLoading() ;
return;
}

// Form Validation
if (!loginFormKey.currentState!.validate()) {
TFullScreenLoader.stopLoading();
return;
}

// save Data if Remember Me is selected
if (rememberMe.value) {
localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
}

// Login user using EMail & Password Authentication
final userCredentials = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

// Remove Loader
TFullScreenLoader.stopLoading() ;

// Redirect
AuthenticationRepository.instance.screenRedirect();
}catch (e) {
TFullScreenLoader.stopLoading() ;
TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
}
}

/// -- Google SignIn Authentication
Future<void> googleSignIn() async {
try {
// Start Loading
TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.handshake);

// Check Internet Connectivity
final isConnected = await NetworkManager.instance.isConnected();
if (!isConnected) {
TFullScreenLoader.stopLoading() ;
return;
}

// Google Authentication
// final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

// Save User Record
// await userController.saveUserRecord(userCredentials);

//Remove Loader
TFullScreenLoader.stopLoading();

//Redirect
AuthenticationRepository.instance.screenRedirect();

} catch (e) {
  //Remove Loader
TFullScreenLoader.stopLoading();
TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

}
}
@override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
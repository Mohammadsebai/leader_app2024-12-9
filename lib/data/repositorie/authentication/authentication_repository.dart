import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leader_app/features/authentication/screens/login/login.dart';
import 'package:leader_app/features/start_screen.dart';
import 'package:leader_app/utils/exceptions/platform_exceptions.dart';
import 'package:leader_app/utils/local_storage/storage_utility.dart';

import 'package:searchfield/searchfield.dart';

import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';

class AuthenticationRepository extends GetxController { 
  static AuthenticationRepository get instance => Get.find();

/// Variables
final deviceStorage = GetStorage();
final _auth = FirebaseAuth.instance;

///Get Authenticated user Data
User? get authUser => _auth.currentUser;

/// Called from main.dart on app Launch
@override
void onReady() {
FlutterNativeSplash.remove();
screenRedirect();
}

/// Function to Show Relevant Screen
 void screenRedirect() async {
  final user = _auth.currentUser;

  if(user !=null){
 //   if(user.emailVerified){


      // Initialize User Specific Storage
       await TLocalStorage.init(user.uid);

     ///AtoZ/ Get.offAll(()=> const NavigationMenu());
      Get.offAll(()=> const StartScreen());
   // }else{
     // Get.offAll(()=>  VerifyEmailScreen(email: _auth.currentUser?.email,));
   // }
  }else{
    // Local Storage
// deviceStorage.writeIfNull('IsFirstTime', true);
//check if it's the first time launching the app 
// deviceStorage.read('IsFirstTime') != true
// ?
 Get.offAll(() => const LoginScreen()); //Redirect to Login screen if not the first time
// : Get.offAll(const OnBoardingScreen());//Redirect to OnBoarding screen if it's  the first time

  }

}

///-- Get all universities
  /// Variables
  final _db = FirebaseFirestore.instance;

  Future<List<SearchFieldListItem>> getAllUniversities() async {
    try {
     final QuerySnapshot snapshot = await _db.collection('Universities').get();
    final List<SearchFieldListItem> universityNames = snapshot.docs.map((doc) =>  SearchFieldListItem(doc['universityName'].toString())).toList();
    return universityNames;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }



  ///getAllDepatment
  
  Future<List<SearchFieldListItem>> getAllDepatment(String University) async {
    try {
     final DocumentReference parentDocRef = _db.collection('Universities').doc(University);
     final CollectionReference subCollectionRef = parentDocRef.collection('depatments');
     final QuerySnapshot querySnapshot =await subCollectionRef.get();
    final List<SearchFieldListItem> universityNames = querySnapshot.docs.map((doc) =>  SearchFieldListItem(doc['depatmentName'].toString())).toList();
    return universityNames;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while fetching Banners.';
    }
  }



/*------------------------- Enail & Password sign-in----------------------------------------*/
/// [EmailAuthentication] - LOGIN

Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
try {
return await _auth.signInWithEmailAndPassword(email: email, password: password);
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}

/// [EnailAuthentication] REGISTER
Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
try {
return await _auth.createUserWithEmailAndPassword(email: email, password: password);
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
  throw 'Something went wrong . Please try again ';
}
  }


/// [EnailVerification] - MAIL VERIFICATION
Future<void> sendEmailVerification() async {
try {
await _auth.currentUser?.sendEmailVerification();
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e){
throw 'Something went wrong. Please try again';
}
}

/// [EmailAuthentication] FORGET PASSWORD

Future<void> sendPasswordResetEmail(String email) async {
try {
await _auth.sendPasswordResetEmail(email: email);
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}

/// [ReAuthenticate] - RE Authenticate User

Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
try {
// create a credential
AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

// ReAuthenticate
await _auth.currentUser!.reauthenticateWithCredential(credential);
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}


/*-----------------------------Federated identity & social sign-in----------------*/

// [GoogleAuthentication] - GOOGLE
// Future<UserCredential?> signInWithGoogle() async {
//  try {
// // Trigger the authentication flow
// final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

// // Obtain the auth details from the request
// final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

// // create a new credential
// final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

// // Once signed in, return the UserCredential
// return await _auth.signInWithCredential(credentials);
// } on FirebaseAuthException catch (e) {
// throw TFirebaseAuthException(e.code).message;
// } on FirebaseException catch (e) {
// throw TFirebaseException(e.code).message;
// } on FormatException catch (_) {
// throw const TFormatException();
// } on PlatformException catch (e) {
// throw TPlatformException(e.code).message;
// } catch (e) {
// if (kDebugMode) print('Something went wrong: $e');
// return null;
// }
// }


//[Facebook Authentication) - FACEBOOK

/*-------------------------------./end Federated identity & social sign-in-----------------------------------*/


/// [LogoutUser] - Valid for any authentication.
Future<void> logout() async {
try {
await FirebaseAuth.instance.signOut();
Get.offAll(() => const LoginScreen());
} on FirebaseAuthException catch (e) {
throw TFirebaseAuthException(e.code).message;
} on FirebaseException catch (e) {
throw TFirebaseException(e.code).message;
} on FormatException catch (_) {
throw const TFormatException();
} on PlatformException catch (e) {
throw TPlatformException(e.code).message;
} catch (e) {
throw 'Something went wrong. Please try again';
}
}



// DELETE USER -Remove user Auth and Firestore Account

// Future<void> deleteAccount() async {
// try {
// await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
// await _auth.currentUser?.delete();
// } on FirebaseAuthException catch (e) {
// throw TFirebaseAuthException(e.code).message;
// } on FirebaseException catch (e) {
// throw TFirebaseException(e.code).message;
// } on FormatException catch (_) {
// throw const TFormatException();
// } on PlatformException catch (e) {
// throw TPlatformException(e.code).message;
// } catch (e) {
// throw 'Something went wrong. Please try again';
// }
// }


}
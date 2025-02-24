// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyALky9CqYAUuS1hDLZIn6g_KIJWXA_M-Wc',
    appId: '1:695435971090:web:b271ca336a2c4685b466cb',
    messagingSenderId: '695435971090',
    projectId: 'newlife2001-49c6c',
    authDomain: 'newlife2001-49c6c.firebaseapp.com',
    storageBucket: 'newlife2001-49c6c.appspot.com',
    measurementId: 'G-MY3F573679',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB38pS5Ku49DgzcVo8tWYp8HjnwISJC4h0',
    appId: '1:695435971090:android:a5b72e00bebd7e14b466cb',
    messagingSenderId: '695435971090',
    projectId: 'newlife2001-49c6c',
    storageBucket: 'newlife2001-49c6c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB7wM7ljVP5xBIw94NIOm5kMx0Q7cGhq5c',
    appId: '1:695435971090:ios:aa2c87ed0bdf28f1b466cb',
    messagingSenderId: '695435971090',
    projectId: 'newlife2001-49c6c',
    storageBucket: 'newlife2001-49c6c.appspot.com',
    iosBundleId: 'com.example.leaderApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB7wM7ljVP5xBIw94NIOm5kMx0Q7cGhq5c',
    appId: '1:695435971090:ios:0929f90c3dc12561b466cb',
    messagingSenderId: '695435971090',
    projectId: 'newlife2001-49c6c',
    storageBucket: 'newlife2001-49c6c.appspot.com',
    iosBundleId: 'com.example.leaderApp.RunnerTests',
  );
}

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBnOKT84VwJpt83FO3UT_N5r8A9OUqbYO8',
    appId: '1:129455027629:web:fa6aab3df2d5eff8571d24',
    messagingSenderId: '129455027629',
    projectId: 'motor-3123d',
    authDomain: 'motor-3123d.firebaseapp.com',
    storageBucket: 'motor-3123d.appspot.com',
    measurementId: 'G-EXNYBTWMCE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeLc7y8x8BP1kC6dl1vtS0SOCkajeZVm8',
    appId: '1:129455027629:android:5bba5c9d22d6c4bb571d24',
    messagingSenderId: '129455027629',
    projectId: 'motor-3123d',
    storageBucket: 'motor-3123d.appspot.com',
  );
}

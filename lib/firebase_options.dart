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
    apiKey: 'AIzaSyCp4waTvQqXoIE6KxQ3AkbhjdKF6FFTbfk',
    appId: '1:416444749783:web:937cdf20bf060a8f129d92',
    messagingSenderId: '416444749783',
    projectId: 'weing-bb503',
    authDomain: 'weing-bb503.firebaseapp.com',
    storageBucket: 'weing-bb503.appspot.com',
    measurementId: 'G-7WD1NCHETN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZJ8Ryj8q3OWJ408per6vNxxHeDW5NTic',
    appId: '1:416444749783:android:67fe06b73bdddb89129d92',
    messagingSenderId: '416444749783',
    projectId: 'weing-bb503',
    storageBucket: 'weing-bb503.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDYQumdkp0Rks2_MHIk3f0hKOErye8tuAw',
    appId: '1:416444749783:ios:c385331f527ce53f129d92',
    messagingSenderId: '416444749783',
    projectId: 'weing-bb503',
    storageBucket: 'weing-bb503.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDYQumdkp0Rks2_MHIk3f0hKOErye8tuAw',
    appId: '1:416444749783:ios:695527939c863d65129d92',
    messagingSenderId: '416444749783',
    projectId: 'weing-bb503',
    storageBucket: 'weing-bb503.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}

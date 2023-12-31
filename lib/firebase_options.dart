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
    apiKey: 'AIzaSyA-9C8c1W2q15bAipgr5CTT6zbEo8qFKVU',
    appId: '1:448365911896:web:5f9b2726c678dce21d4f2d',
    messagingSenderId: '448365911896',
    projectId: 'token-system-b5d30',
    authDomain: 'token-system-b5d30.firebaseapp.com',
    databaseURL: 'https://token-system-b5d30-default-rtdb.firebaseio.com',
    storageBucket: 'token-system-b5d30.appspot.com',
    measurementId: 'G-JLBRYZSKLV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9XZk8Ke3FZamn_NhMJn_bKsIgcwtrtbE',
    appId: '1:448365911896:android:bd38df6d92f99c6e1d4f2d',
    messagingSenderId: '448365911896',
    projectId: 'token-system-b5d30',
    databaseURL: 'https://token-system-b5d30-default-rtdb.firebaseio.com',
    storageBucket: 'token-system-b5d30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCa20B-RnK6mr4nMhovdnPOb9wDfNcsmLY',
    appId: '1:448365911896:ios:8673a56506d3d0bd1d4f2d',
    messagingSenderId: '448365911896',
    projectId: 'token-system-b5d30',
    databaseURL: 'https://token-system-b5d30-default-rtdb.firebaseio.com',
    storageBucket: 'token-system-b5d30.appspot.com',
    iosClientId: '448365911896-bsqd8lp625ri93v0j6qj1om06h9343uc.apps.googleusercontent.com',
    iosBundleId: 'com.example.token',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCa20B-RnK6mr4nMhovdnPOb9wDfNcsmLY',
    appId: '1:448365911896:ios:b08bca8d86742a571d4f2d',
    messagingSenderId: '448365911896',
    projectId: 'token-system-b5d30',
    databaseURL: 'https://token-system-b5d30-default-rtdb.firebaseio.com',
    storageBucket: 'token-system-b5d30.appspot.com',
    iosClientId: '448365911896-klldf8crsdfivfejohpv7oabm7mdsk06.apps.googleusercontent.com',
    iosBundleId: 'com.example.token.RunnerTests',
  );
}

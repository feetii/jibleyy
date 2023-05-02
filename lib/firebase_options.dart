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
    apiKey: 'AIzaSyDRltO7ZTK26oPT9-JY_auLp_qdShTbC0Q',
    appId: '1:953169170049:web:e76fdbe7249c4f7c92c780',
    messagingSenderId: '953169170049',
    projectId: 'jibley',
    authDomain: 'jibley.firebaseapp.com',
    storageBucket: 'jibley.appspot.com',
    measurementId: 'G-CHYVN7SF5D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6tCAZ6RF-2hKSeJQG_KlIU82i63dpYqQ',
    appId: '1:953169170049:android:18e142a2ec14b1dc92c780',
    messagingSenderId: '953169170049',
    projectId: 'jibley',
    storageBucket: 'jibley.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4AtreC2zxTNjlqPl3fYC_npizxNzT5KA',
    appId: '1:953169170049:ios:6dbbf3e09633559d92c780',
    messagingSenderId: '953169170049',
    projectId: 'jibley',
    storageBucket: 'jibley.appspot.com',
    iosClientId: '953169170049-lq26v65c7s2n998g0uuhs98n4ohg7gln.apps.googleusercontent.com',
    iosBundleId: 'com.example.jibley',
  );
}

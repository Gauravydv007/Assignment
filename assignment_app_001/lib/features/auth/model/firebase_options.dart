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
    apiKey: 'AIzaSyB6RVOOwIg6wZPX-R5NpxVhRKct4QrNvvM',
    appId: '1:908005871166:web:3ecc844379189632214b6f',
    messagingSenderId: '908005871166',
    projectId: 'assignment-db7d2',
    authDomain: 'assignment-db7d2.firebaseapp.com',
    storageBucket: 'assignment-db7d2.appspot.com',
    measurementId: 'G-59NNM7KBTZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcoB9MsZHNGk3Zw7VEiEq6npRZJ8WO0Y0',
    appId: '1:908005871166:android:163ec18eee108d88214b6f',
    messagingSenderId: '908005871166',
    projectId: 'assignment-db7d2',
    storageBucket: 'assignment-db7d2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCj5JL5oYbFZkGKhEsLOgdEocrvsOjfp_Y',
    appId: '1:908005871166:ios:67c3848c2b79cdb7214b6f',
    messagingSenderId: '908005871166',
    projectId: 'assignment-db7d2',
    storageBucket: 'assignment-db7d2.appspot.com',
    iosBundleId: 'com.example.assignmentApp001',
  );
}

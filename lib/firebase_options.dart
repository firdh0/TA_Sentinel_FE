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
    apiKey: 'AIzaSyDp1E_LxGBYNyhwEFsLypZVQHAbyjHu568',
    appId: '1:514035414237:web:eb9ce7a65cf76cf08c5734',
    messagingSenderId: '514035414237',
    projectId: 'ta-sentinel-fcm',
    authDomain: 'ta-sentinel-fcm.firebaseapp.com',
    storageBucket: 'ta-sentinel-fcm.appspot.com',
    measurementId: 'G-0735N451T9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0CyOTCA8ZJqhiZTo4cedXPMIgzqafWvE',
    appId: '1:514035414237:android:e9ee8b7f3f68aadb8c5734',
    messagingSenderId: '514035414237',
    projectId: 'ta-sentinel-fcm',
    storageBucket: 'ta-sentinel-fcm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwGIaQa9JBGSt8tpagvW-6ioWaxpJnyok',
    appId: '1:514035414237:ios:c2c24ed280a888518c5734',
    messagingSenderId: '514035414237',
    projectId: 'ta-sentinel-fcm',
    storageBucket: 'ta-sentinel-fcm.appspot.com',
    iosBundleId: 'com.example.chatArmor',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwGIaQa9JBGSt8tpagvW-6ioWaxpJnyok',
    appId: '1:514035414237:ios:c2c24ed280a888518c5734',
    messagingSenderId: '514035414237',
    projectId: 'ta-sentinel-fcm',
    storageBucket: 'ta-sentinel-fcm.appspot.com',
    iosBundleId: 'com.example.chatArmor',
  );
}

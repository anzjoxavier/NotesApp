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
    apiKey: 'AIzaSyARTPxKYTsAPZsfXO4WsvhwYGs5DnyPIeE',
    appId: '1:50347409152:web:3a532fffe542097c59bde5',
    messagingSenderId: '50347409152',
    projectId: 'simpleprojectbyanzjo',
    authDomain: 'simpleprojectbyanzjo.firebaseapp.com',
    storageBucket: 'simpleprojectbyanzjo.appspot.com',
    measurementId: 'G-SPD182K6QT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoK8A2uRJVKimExUTT1I05JkW-j5Vy-40',
    appId: '1:50347409152:android:bb95aaf29f2b890959bde5',
    messagingSenderId: '50347409152',
    projectId: 'simpleprojectbyanzjo',
    storageBucket: 'simpleprojectbyanzjo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuAyyOQ9P5An9sy0kZMBAHezTrm7NFMQU',
    appId: '1:50347409152:ios:52b9a9478b1f563559bde5',
    messagingSenderId: '50347409152',
    projectId: 'simpleprojectbyanzjo',
    storageBucket: 'simpleprojectbyanzjo.appspot.com',
    iosClientId: '50347409152-jpp0co2ivqfofo3as4ovmam91hq1pnam.apps.googleusercontent.com',
    iosBundleId: 'com.example.simpleproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuAyyOQ9P5An9sy0kZMBAHezTrm7NFMQU',
    appId: '1:50347409152:ios:52b9a9478b1f563559bde5',
    messagingSenderId: '50347409152',
    projectId: 'simpleprojectbyanzjo',
    storageBucket: 'simpleprojectbyanzjo.appspot.com',
    iosClientId: '50347409152-jpp0co2ivqfofo3as4ovmam91hq1pnam.apps.googleusercontent.com',
    iosBundleId: 'com.example.simpleproject',
  );
}
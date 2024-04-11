import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyCb1Sa7TE5z7QSCpYA-8X4HZJROhCyiAj0',
    appId: '1:582225684067:web:cd1062802a1fb396183a56',
    messagingSenderId: '582225684067',
    projectId: 'doannn-dbdb3',
    authDomain: 'easyshopping-ce06a.firebaseapp.com',
    storageBucket: 'doannn-dbdb3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCb1Sa7TE5z7QSCpYA-8X4HZJROhCyiAj0',
    appId: '1:582225684067:android:83e808439faa9229183a56',
    messagingSenderId: '582225684067',
    projectId: 'doannn-dbdb3',
    storageBucket: 'doannn-dbdb3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCb1Sa7TE5z7QSCpYA-8X4HZJROhCyiAj0',
    appId: '1:582225684067:android:83e808439faa9229183a56',
    messagingSenderId: '582225684067',
    projectId: 'doannn-dbdb3',
    storageBucket: 'doannn-dbdb3.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCb1Sa7TE5z7QSCpYA-8X4HZJROhCyiAj0',
    appId: '1:582225684067:android:83e808439faa9229183a56',
    messagingSenderId: '582225684067',
    projectId: 'doannn-dbdb3',
    storageBucket: 'doannn-dbdb3.appspot.com',
  );
}

// FirebaseOptions firebaseOptions = FirebaseOptions(
//     apiKey: 'AIzaSyCb1Sa7TE5z7QSCpYA-8X4HZJROhCyiAj0',
//     appId: '1:582225684067:android:83e808439faa9229183a56',
//     messagingSenderId: '582225684067',
//     projectId: 'doannn-dbdb3',
//     storageBucket: 'doannn-dbdb3.appspot.com'
// );
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simpleproject/views/login_view.dart';
import 'package:simpleproject/views/register_view.dart';
import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes:{
      '/LoginView/':((context) => const LoginView()),
      '/RegisterView/':((context) => const RegisterView()),
    }
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // final user = FirebaseAuth.instance.currentUser;
                // if (user?.emailVerified == true) {
                //   return const Text("Done");
                // } else {
                //   return const VerifyEmailView();
                // }
                return const LoginView();
              default:
                return const Scaffold(
                  body:  Center(child: CircularProgressIndicator()));
            }
          });
  }
}



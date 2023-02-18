import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:simpleproject/constants/route.dart';
import 'package:simpleproject/services/auth/auth_service.dart';
import 'package:simpleproject/views/login_view.dart';
import 'package:simpleproject/views/notes/create_upadate_note_view.dart';
import 'package:simpleproject/views/notes/notes_view.dart';
import 'package:simpleproject/views/register_view.dart';
import 'package:simpleproject/views/verify_email.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        LoginRoute: ((context) => const LoginView()),
        RegisterRoute: ((context) => const RegisterView()),
        NotesRoute: ((context) => const NotesView()),
        VerifyEmailRoute: (context) => const VerifyEmailView(),
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView()
      }));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null) {
                if (user.isEmailVerified != true) {
                  return const VerifyEmailView();
                } else {
                  return const NotesView();
                }
              } else {
                return const LoginView();
              }

            default:
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}

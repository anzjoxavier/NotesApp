import 'package:flutter/material.dart';
import 'package:simpleproject/constants/route.dart';
import 'package:simpleproject/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Column(
        children: [
          const Text("Verification Email has been send please verify it."),
          const Text(
              "If you haven't received email yet, press the button below."),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
                
              },
              child: const Text("Verify Email")),
          TextButton(
              onPressed: () async {
                
                await AuthService.firebase().logOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(RegisterRoute, (route) => false);
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}

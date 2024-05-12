import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class loginUserPage extends StatefulWidget {
  const loginUserPage({super.key});

  @override
  State<loginUserPage> createState() => _loginUserPageState();
}

class _loginUserPageState extends State<loginUserPage> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        child: '로그아웃'.text.bold.black.make());
  }
}

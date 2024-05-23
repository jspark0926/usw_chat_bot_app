import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginUser extends StatefulWidget {
  final String emailAddress;
  final String password;

  const LoginUser({
    super.key,
    required this.emailAddress,
    required this.password,
  });

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  late String emailAddress = widget.emailAddress;
  late String password = widget.password;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () async {
        try {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailAddress, password: password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: '등록되지 않은 이메일주소 입니다'.text.bold.white.size(20).make(),
              ),
            );
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: '비밀번호가 틀립니다'.text.bold.white.size(20).make(),
              ),
            );
          }
        }
      },
      child: '로그인'.text.black.bold.size(20).make(),
    );
  }
}

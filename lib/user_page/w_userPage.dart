import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/user_page/s_login_user_page.dart';
import 'package:usw_chat_bot_app/user_page/s_logout_user_page.dart';

class userPage extends StatefulWidget {
  const userPage({super.key});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  late bool? loginState;


  @override
  void initState() {
    super.initState();
    loginState = null;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user != null) {
        setState(() {
          loginState = true;
        });
      } else {
        setState(() {
          loginState = false;
        });
      }
    });
    if (loginState == false || loginState == null) {
      return const logoutUserPage();
    }  else {
      return const loginUserPage();
    }
  }
}

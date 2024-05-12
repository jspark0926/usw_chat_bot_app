import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/main_page/s_login_main_page.dart';
import 'package:usw_chat_bot_app/main_page/s_logout_main_page.dart';

import '../auth_provider2.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  // late bool? loginState;
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   loginState = false;
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider2>(context);

    // FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((User? user) {
    //   if (user != null) {
    //     setState(() {
    //       loginState = true;
    //     });
    //   } else {
    //     setState(() {
    //       loginState = false;
    //     });
    //   }
    // });
    // if (loginState == false || loginState == null) {
    //   return const logoutMainPage();
    // }  else {
    //   return const loginMainPage();
    // }
    if (authProvider.user != null) {
      return const loginMainPage();
    } else {
      return const logoutMainPage();
    }
  }
}

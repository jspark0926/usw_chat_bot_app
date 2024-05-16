import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/main_page/s_login_main_page.dart';
import 'package:usw_chat_bot_app/main_page/s_logout_main_page.dart';
import 'package:usw_chat_bot_app/provider/auth_provider2.dart';



class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider2>(context);

    if (authProvider.user != null) {
      return const loginMainPage();
    } else {
      return const logoutMainPage();
    }
  }
}

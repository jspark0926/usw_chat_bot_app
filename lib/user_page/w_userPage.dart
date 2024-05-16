import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/user_page/s_login_user_page.dart';
import 'package:usw_chat_bot_app/user_page/s_logout_user_page.dart';

import '../provider/auth_provider2.dart';

class userPage extends StatefulWidget {
  const userPage({super.key});

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider2>(context);

    if (authProvider.user != null) {
      return const loginUserPage();
    } else {
      return const logoutUserPage();
    }
  }
}

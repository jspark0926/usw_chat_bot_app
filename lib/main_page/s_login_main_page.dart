import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/main_page/chat_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class loginMainPage extends StatefulWidget {
  const loginMainPage({super.key});

  @override
  State<loginMainPage> createState() => _loginMainPageState();
}

class _loginMainPageState extends State<loginMainPage> {

  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

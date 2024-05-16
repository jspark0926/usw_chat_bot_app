import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/chat_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class loginMainPage extends StatefulWidget {
  const loginMainPage({super.key});

  @override
  State<loginMainPage> createState() => _loginMainPageState();
}

class _loginMainPageState extends State<loginMainPage> {
  late String userText = '';
  final scrollController = ScrollController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Expanded(child: ChatScreen()),
    //     TextField(
    //       onChanged: (text) {
    //         setState(() {
    //           userText = text;
    //         });
    //       },
    //       obscureText: true,
    //       decoration: const InputDecoration(
    //         border: OutlineInputBorder(),
    //         labelText: 'Password',
    //       ),
    //     ),
    //   ],
    // );
    return ChatScreen();
  }
}

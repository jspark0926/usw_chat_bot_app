import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class logoutMainPage extends StatefulWidget {
  const logoutMainPage({super.key});

  @override
  State<logoutMainPage> createState() => _logoutMainPageState();
}

class _logoutMainPageState extends State<logoutMainPage> {
  @override
  Widget build(BuildContext context) {
      return DefaultLayout(
        loginState: false,
        title: '',
        child: Center(
          child: Column(
            children: [
              const HeightBox(300),
              '로그인 후 서비스 이용이 가능합니다'.text.bold.size(28).black.make().p(40),
            ],
          ),
        ),
      );
  }
}

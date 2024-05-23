import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UswChatBotAppLogo extends StatelessWidget {
  const UswChatBotAppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        '수정상'.text.black.bold.size(80).make(),
        '수원대 정보 만물상'.text.black.bold.size(20).make(),
      ],
    );
  }
}

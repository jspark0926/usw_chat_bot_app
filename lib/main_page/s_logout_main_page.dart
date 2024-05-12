import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class logoutMainPage extends StatefulWidget {
  const logoutMainPage({super.key});

  @override
  State<logoutMainPage> createState() => _logoutMainPageState();
}

class _logoutMainPageState extends State<logoutMainPage> {
  late int loginIndex;

  @override
  void initState() {
    super.initState();
    loginIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (loginIndex == 0) {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            '로그인 후 서비스 이용이 가능합니다'.text.bold.size(28).black.make().p(40),
            InkWell(
              child: Container(
                width: 180,
                height: 33,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(child: '로그인 하러 가기'.text.size(18).bold.make()),
              ),
              onTap: () {
              },
            ),
          ],
        ),
      );
    }
    return Placeholder();
  }
}

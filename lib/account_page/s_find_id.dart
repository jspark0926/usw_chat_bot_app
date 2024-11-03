import 'package:flutter/material.dart';
import '../common/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class FindId extends StatefulWidget {
  const FindId({super.key});

  @override
  State<FindId> createState() => _FindIdState();
}

class _FindIdState extends State<FindId> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: Column(
        children: [
          const SizedBox(height: 150),
          '수정상'.text.black.bold.size(80).make(),
          '수원대 정보 만물상'.text.black.bold.size(20).make(),
          const SizedBox(height: 50),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이메일 입력',
            ),
          ),
          const HeightBox(30),
          InkWell(
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: '인증번호 전송'.text.black.bold.size(20).make()),
            ),
            onTap: () {},
          ),
          const HeightBox(30),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '인증번호 입력',
            ),
          ),
          HeightBox(30),
          InkWell(
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: '확인'.text.black.bold.size(20).make()),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

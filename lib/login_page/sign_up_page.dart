import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../default_Layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightBox(150),
            '수정상'.text.black.bold.size(80).make(),
            '수원대 정보 만물상'.text.black.bold.size(20).make(),
            const HeightBox(50),
            ///////////////////////////////////////////////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '아이디 입력'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            ///////////////////////////////////////////////////////////////////
            const HeightBox(10),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID',
              ),
            ).pSymmetric(h: 20),
            const HeightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '비밀번호 입력'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
        
                labelText: 'Password',
              ),
            ).pSymmetric(h: 20),
            const HeightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '비밀번호 확인'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            HeightBox(10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
        
                labelText: 'Password',
              ),
            ).pSymmetric(h: 20),
            const HeightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '이메일 입력'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(10),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ).pSymmetric(h: 20),
            const HeightBox(30),
            InkWell(
              child: Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: '저장'.text.black.bold.size(20).make()),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/account_page/s_update_password_page.dart';
import 'package:usw_chat_bot_app/inquire_page/s_about_inquire_page.dart';
import 'package:usw_chat_bot_app/inquire_page/s_receive_inquire_page.dart';
import 'package:velocity_x/velocity_x.dart';

class loginUserPage extends StatefulWidget {
  const loginUserPage({super.key});

  @override
  State<loginUserPage> createState() => _loginUserPageState();
}

class _loginUserPageState extends State<loginUserPage> {
  late var userName = "jspark0926";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          HeightBox(50),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          HeightBox(30),
          Container(
            width: 160,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
            ),
            child: Center(child: userName.text.black.bold.size(12).make()),
          ),
          HeightBox(30),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const updatePasswordPage(),
                  ),
                );
              });
            },
            child: Container(
              width: double.infinity,
              height: 63,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              child: Center(
                child: '비밀번호 변경'.text.black.size(20).make(),
              ),
            ),
          ),
          HeightBox(5),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const aboutInquirePage(),
                  ),
                );
              });
            },
            child: Container(
              width: double.infinity,
              height: 63,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              child: Center(
                child: '문의 내역 조회'.text.black.size(20).make(),
              ),
            ),
          ),
          HeightBox(5),
          InkWell(
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const receiveInquirePage(),
                  ),
                );
              });
            },
            child: Container(
              width: double.infinity,
              height: 63,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
              ),
              child: Center(
                child: '문의 내용 접수'.text.black.size(20).make(),
              ),
            ),
          ),
          HeightBox(60),
          OutlinedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: '로그아웃'.text.bold.black.make(),
          )
        ],
      ),
    );
  }
}

// OutlinedButton(
// onPressed: () async {
// await FirebaseAuth.instance.signOut();
// },
// child: '로그아웃'.text.bold.black.make());

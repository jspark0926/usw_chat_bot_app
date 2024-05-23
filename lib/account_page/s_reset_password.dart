import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_data_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../w_layout/w_default_Layout.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late AuthDataProvider authProvider = Provider.of<AuthDataProvider>(context, listen: false);
  late var emailAdress = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 150),
            '수정상'.text.black.bold.size(80).make(),
            '수원대 정보 만물상'.text.black.bold.size(20).make(),
            const SizedBox(height: 100),
            const HeightBox(30),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이메일 입력',
              ),
              onChanged: (text){
                setState(() {
                  emailAdress = text;
                });
              },
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
                child: Center(child: '비밀번호 재설정 코드 전송'.text.black.bold.size(20).make()),
              ),
              onTap: () {
                authProvider.resetPassword(emailAdress);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: '비밀번호 재설정 메일을 보냈습니다.'.text.bold.white.size(20).make(),
                  ),
                );
              },
            ),
            const HeightBox(50),
            InkWell(
              child: Container(
                width: 200,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: '뒤로가기'.text.black.bold.size(20).make()),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

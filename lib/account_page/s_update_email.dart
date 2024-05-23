import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_data_provider.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateEmail extends StatefulWidget {
  const UpdateEmail({super.key});

  @override
  State<UpdateEmail> createState() => _UpdateEmailState();
}

class _UpdateEmailState extends State<UpdateEmail> {
  late AuthDataProvider authProvider =
      Provider.of<AuthDataProvider>(context, listen: false);
  late String emailAddress = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '이메일 입력',
              ),
              onChanged: (text) {
                setState(() {
                  emailAddress = text;
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
                child: Center(
                  child: '이메일 재설정'.text.black.bold.size(20).make(),
                ),
              ),
              onTap: () async {
                authProvider.VerifyBeforeUpdateEmail(emailAddress);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: '이메일 변경이 완료되었습니다'.text.bold.white.size(20).make(),
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

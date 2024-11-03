import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_data_provider.dart';
import 'package:usw_chat_bot_app/common/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class updatePasswordPage extends StatefulWidget {
  const updatePasswordPage({super.key});

  @override
  State<updatePasswordPage> createState() => _updatePasswordPageState();
}

class _updatePasswordPageState extends State<updatePasswordPage> {
  // final firebaseAuth = FirebaseAuth.instance;
  late String newPassword = '';
  late String verifyPassword = '';
  late AuthDataProvider authProvider =
      Provider.of<AuthDataProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeightBox(150),
              '수정상'.text.black.bold.size(80).make(),
              '수원대 정보 만물상'.text.black.bold.size(20).make(),
              const HeightBox(120),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '새로운 비밀번호'.text.black.size(20).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  labelText: 'New Password',
                ),
                onChanged: (text) {
                  setState(() {
                    newPassword = text;
                  });
                },
              ).pSymmetric(h: 20),
              const HeightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '비밀번호 확인'.text.black.size(20).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  labelText: 'Verify Password',
                ),
                onChanged: (text) {
                  setState(() {
                    verifyPassword = text;
                  });
                },
              ).pSymmetric(h: 20),
              const HeightBox(20),
              OutlinedButton(
                onPressed: () {
                  if(newPassword == verifyPassword) {
                    authProvider.passwordUpdate(newPassword);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '비밀번호가 변경되었습니다'.text.bold.white.size(20).make(),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '비밀번호가 일치하지 않습니다'.text.bold.white.size(20).make(),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: '저장'.text.black.size(20).make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

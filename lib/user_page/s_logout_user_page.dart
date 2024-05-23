import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/account_page/w_login_user.dart';
import 'package:usw_chat_bot_app/provider/auth_data_provider.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:usw_chat_bot_app/w_usw_chat_bot_app_logo.dart';
import '../account_page/s_reset_password.dart';
import '../account_page/s_signup_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogoutUserPage extends StatefulWidget {
  const LogoutUserPage({super.key});

  @override
  State<LogoutUserPage> createState() => _LogoutUserPageState();
}

class _LogoutUserPageState extends State<LogoutUserPage> {
  late String emailAddress = '';
  late String password = '';
  late AuthDataProvider authProvider =
      Provider.of<AuthDataProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: false,
      title: '',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightBox(150),
            const UswChatBotAppLogo(),
            const HeightBox(50),
            TextField(
              onChanged: (text) {
                setState(() {
                  emailAddress = text;
                });
              },
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ).pSymmetric(h: 20),
            TextField(
              onChanged: (text) {
                setState(() {
                  password = text;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ).pSymmetric(h: 20),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: "회원가입".text.black.size(16).make().pOnly(left: 20),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPassword()));
                  },
                  child: "비밀번호를 잊으셨나요?"
                      .text
                      .black
                      .size(16)
                      .make()
                      .pOnly(left: 20)
                      .pOnly(right: 20),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    authProvider.signInWithGoogle();
                  },
                  icon: Image.asset(
                    'assets/images/android_light_sq_SU@1x.png',
                    width: 206,
                    height: 46,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                try {
                  final userCredential =
                      await FirebaseAuth.instance.signInAnonymously();
                  print("Signed in with temporary account.");
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            '등록된 이메일이 없습니다'.text.bold.white.size(20).make(),
                      ),
                    );
                  } else if (e.code == 'wrong-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '비밀번호가 틀립니다.'.text.bold.white.size(20).make(),
                      ),
                    );
                  }
                }
              },
              child: Container(
                width: 185,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(child: ' 익명 로그인'.text.white.bold.size(20).make()),
              ),
            ),
            const HeightBox(10),
            LoginUser(
              emailAddress: emailAddress,
              password: password,
            ),
          ],
        ),
      ),
    );
  }
}

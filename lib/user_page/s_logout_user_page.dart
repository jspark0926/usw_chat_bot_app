import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_data_provider.dart';
import 'package:usw_chat_bot_app/common/w_default_Layout.dart';
import 'package:usw_chat_bot_app/w_usw_chat_bot_app_logo.dart';
import '../account_page/s_reset_password.dart';
import '../account_page/s_signup_page.dart';
import 'package:velocity_x/velocity_x.dart';

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

  void _signIn() async {
    try {
      await authProvider.signIn(emailAddress, password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: '로그인 성공'.text.bold.white.make(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: '아이디와 비밀번호를 확인해주세요'.text.bold.white.make(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: '로그인 중 알 수 없는 오류가 발생했습니다: \n$e'.text.bold.white.make(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthDataProvider>().user;

    return DefaultLayout(
        loginState: user != null,
      title: '',
      child: user == null
          ? SingleChildScrollView(
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
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child:
                            "회원가입".text.black.size(16).make().pOnly(left: 20),
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        },
                        child: "비밀번호를 잊으셨나요?"
                            .text
                            .black
                            .size(16)
                            .make()
                            .pOnly(right: 20),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () async {
                          try {
                            await authProvider.signInWithGoogle();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    'Google 로그인 실패:\n$e'.text.bold.white.make(),
                              ),
                            );
                          }
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
                        await FirebaseAuth.instance.signInAnonymously();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: '익명 로그인 성공'.text.bold.white.make(),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: '익명 로그인 실패: $e'.text.bold.white.make(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 185,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: ' 익명 로그인'.text.white.bold.size(20).make()),
                    ),
                  ),
                  const HeightBox(10),
                  OutlinedButton(
                    onPressed: _signIn,
                    child: '로그인'.text.black.bold.size(20).make(),
                  )
                ],
              ),
            )
          : Center(child: CircularProgressIndicator(),)
    );
  }
}

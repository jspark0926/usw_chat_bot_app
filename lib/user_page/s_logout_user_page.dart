import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_provider2.dart';
import '../account_page/s_find_password.dart';
import '../account_page/s_find_id.dart';
import '../account_page/s_signup_page.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_sign_in/google_sign_in.dart';

class logoutUserPage extends StatefulWidget {
  const logoutUserPage({super.key});

  @override
  State<logoutUserPage> createState() => _logoutUserPageState();
}

class _logoutUserPageState extends State<logoutUserPage> {
  late String emailAddress = '';
  late String password = '';
  late AuthProvider2 authProvider = Provider.of<AuthProvider2>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 150),
          '수정상'.text.black.bold.size(80).make(),
          '수원대 정보 만물상'.text.black.bold.size(20).make(),
          const SizedBox(height: 50),
          TextField(
            onChanged: (text) {
              setState(() {
                emailAddress = text;
              });
            },
            obscureText: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'ID',
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
                // child: TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const FindId()));
                //   },
                //   child: "아이디 찾기".text.black.size(16).make().pOnly(left: 20),
                // ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FindPassword()));
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
                  // authProvider.signInWithGoogle();
                  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
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
                      content: '등록된 이메일이 없습니다'.text.bold.white.size(20).make(),
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
          HeightBox(10),
          OutlinedButton(
            onPressed: () async {
              try {
                final credential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailAddress, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            },
            child: '로그인'.text.black.bold.size(20).make(),
          ),
        ],
      ),
    );
  }
}

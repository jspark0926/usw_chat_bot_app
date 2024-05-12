import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../account_page/s_find_password.dart';
import '../account_page/s_find_id.dart';
import '../account_page/s_signup_page.dart';
import 'package:velocity_x/velocity_x.dart';

class logoutUserPage extends StatefulWidget {
  const logoutUserPage({super.key});

  @override
  State<logoutUserPage> createState() => _logoutUserPageState();
}

class _logoutUserPageState extends State<logoutUserPage> {
  late String emailAddress = '';
  late String password = '';


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
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FindId()));
                  },
                  child: "아이디 찾기".text.black.size(16).make().pOnly(left: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FindPassword()));
                },
                child: "비밀번호 찾기"
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
                onPressed: null,
                icon: Image.asset(
                  'assets/images/kakao_login_medium_narrow.png',
                  width: 206,
                  height: 46,
                ),
              ),
              IconButton(
                onPressed: null,
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
                switch (e.code) {
                  case "operation-not-allowed":
                    print(
                        "Anonymous auth hasn't been enabled for this project.");
                    break;
                  default:
                    print("Unknown error.");
                }
              }
            },
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: ' 익명 로그인'.text.black.bold.size(20).make()),
            ),
          ),
          HeightBox(10),
          InkWell(
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: '로그인'.text.black.bold.size(20).make()),
            ),
            onTap: () async {
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
          ),
        ],
      ),
    );
  }
}

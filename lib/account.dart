import 'package:flutter/material.dart';
import 'package:test_file/login_page/FindPassword.dart';
import 'package:test_file/login_page/find_id.dart';
import 'package:test_file/login_page/sign_up_page.dart';
import 'package:velocity_x/velocity_x.dart';

class account extends StatefulWidget {
  const account({super.key});

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              labelText: 'ID',
            ),
          ).pSymmetric(h: 20),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
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
                    MaterialPageRoute(builder: (context) => const SignUpPage())
                  );
                },
                child: "회원가입".text.black.size(16).make().pOnly(left: 20),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FindId())
                    );
                  },
                  child: "아이디 찾기".text.black.size(16).make().pOnly(left: 20),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FindPassword())
                  );
                },
                child: "비밀번호 찾기".text.black.size(16).make().pOnly(left: 20).pOnly(right: 20),
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
            child: Container(
              width: 200,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: '로그인'.text.black.bold.size(20).make()),
            ),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

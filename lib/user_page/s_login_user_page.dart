import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/account_page/s_update_email.dart';
import 'package:usw_chat_bot_app/account_page/s_update_password_page.dart';
import 'package:usw_chat_bot_app/inquire_page/s_inquire_list_page.dart';
import 'package:usw_chat_bot_app/inquire_page/s_receive_inquire_page.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class loginUserPage extends StatefulWidget {
  const loginUserPage({super.key});

  @override
  State<loginUserPage> createState() => _loginUserPageState();
}

class _loginUserPageState extends State<loginUserPage> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser!.email);
      } else {
        // If the user is not logged in, handle appropriately
        // For example, navigate to the login screen
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      title: '',
      child: loggedInUser == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const HeightBox(50),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    const HeightBox(30),
                    if (loggedInUser!.email != null) // Add null check
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 2,),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: loggedInUser!.email!.text.black.bold
                              .size(12)
                              .make().p(10),
                        ),
                      ).pSymmetric(h: 100),
                    const HeightBox(30),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UpdateEmail(),
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
                          child: '이메일 변경'.text.black.size(20).make(),
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
                    const HeightBox(5),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutInquirePage(),
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
                    const HeightBox(5),
                    InkWell(
                      onTap: () {
                        if (loggedInUser!.email != null) {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ReceiveInquirePage(),
                              ),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: '익명 사용자는 문의 기능을 이용하실 수 없습니다'
                                  .text
                                  .bold
                                  .white
                                  .size(20)
                                  .make(),
                            ),
                          );
                        }
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
                    const HeightBox(60),
                    OutlinedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: '로그아웃'.text.bold.black.make(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

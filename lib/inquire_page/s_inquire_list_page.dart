import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/inquire_page/s_inquire_details.dart';
import 'package:usw_chat_bot_app/common/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class AboutInquirePage extends StatefulWidget {
  const AboutInquirePage({super.key});

  @override
  State<AboutInquirePage> createState() => _AboutInquirePageState();
}

class _AboutInquirePageState extends State<AboutInquirePage> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser!.email);
      } else {
        // 사용자 로그인이 안 되어 있을 경우 처리
        // 예: 로그인 화면으로 이동
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getInquireList() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('inquire')
        .doc(loggedInUser!.email)
        .collection('inquire_list')
        .get();

    return querySnapshot.docs
        .map((doc) => {
              ...doc.data() as Map<String, dynamic>,
              'docId': doc.id, // 문서 ID를 추가하여 전달
            })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      title: '',
      child: FutureBuilder(
        future: getInquireList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            var data = snapshot.data as List<Map<String, dynamic>>;
            return Column(
              children: [
                HeightBox(50),
                Center(
                  child: '문의 내역'.text.black.size(40).make(),
                ),
                HeightBox(30),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var document = data[index];
                      return Column(
                        children: [
                          const HeightBox(15),
                          InkWell(
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  '문의 제목 : '.text.black.size(20).make(),
                                  document['title']
                                      .toString()
                                      .text
                                      .black
                                      .size(20)
                                      .make(),
                                ],
                              ).pOnly(left: 20),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InquireDetails(
                                    document: document,
                                  ),
                                ),
                              );
                            },
                          ).pSymmetric(h: 10),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: '오류가 발생했습니다: ${snapshot.error}'.text.black.size(25).make(),
            );
          } else {
            return Center(child: '문의 내역이 없습니다'.text.black.size(25).make());
          }
        },
      ),
    );
  }
}

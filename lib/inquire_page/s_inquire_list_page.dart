import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class aboutInquirePage extends StatefulWidget {
  const aboutInquirePage({super.key});

  @override
  State<aboutInquirePage> createState() => _aboutInquirePageState();
}

class _aboutInquirePageState extends State<aboutInquirePage> {
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

  Future<List<Map<String, dynamic>>> getUserInfo() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('inquire')
        .where('sender', isEqualTo: loggedInUser!.email)
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var data = snapshot.data as List<Map<String, dynamic>>;
            return data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var document = data[index];
                      return Card(
                        child: ListTile(
                          title: Text(document['title']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Type: ${document['type']}"),
                              Text("Contents: ${document['contents']}"),
                              Text("Timestamp: ${document['timestamp']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: '문의 내역이 없습니다'.text.black.bold.size(25).make(),
                  );
          } else if (snapshot.hasError) {
            return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
          } else {
            return const Center(child: Text('문의 내역이 없습니다'));
          }
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';

class ReceiveInquirePage extends StatefulWidget {
  const ReceiveInquirePage({super.key});

  @override
  State<ReceiveInquirePage> createState() => _ReceiveInquirePageState();
}

class _ReceiveInquirePageState extends State<ReceiveInquirePage> {
  final _controllerType = TextEditingController();
  final _controllerTitle = TextEditingController();
  final _controllerContents = TextEditingController();
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
        // If the user is not logged in, handle appropriately
        // For example, navigate to the login screen
      }
    } catch (e) {
      print(e);
    }
  }

  void _sendMessage() async {
    _controllerType.text = _controllerType.text.trim();
    _controllerTitle.text = _controllerTitle.text.trim();
    _controllerContents.text = _controllerContents.text.trim();

    if (loggedInUser != null) {
      if (_controllerType.text.isNotEmpty) {
        if (_controllerTitle.text.isNotEmpty) {
          if (_controllerContents.text.isNotEmpty) {
            // 기존 문서에 새로운 컬렉션 추가
            DocumentReference docRef = FirebaseFirestore.instance
                .collection('inquire')
                .doc(loggedInUser!.email);

            await docRef.collection('inquire_list').add({
              'type': _controllerType.text,
              'title': _controllerTitle.text,
              'contents': _controllerContents.text,
              'timestamp': Timestamp.now(),
            });

            _controllerType.clear();
            _controllerTitle.clear();
            _controllerContents.clear();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: '문의가 접수되었습니다'.text.bold.white.size(20).make(),
              ),
            );

            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: '문의 내용을 입력해주세요'.text.bold.white.size(20).make(),
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: '제목을 입력해주세요'.text.bold.white.size(20).make(),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: '문의 유형이 선택되지 않았습니다'.text.bold.white.size(20).make(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      title: '',
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const HeightBox(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '문의 유형'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                controller: _controllerType,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ).pSymmetric(h: 20),
              const HeightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '제목'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                controller: _controllerTitle,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  // hintText: '제목',  //글자를 입력하면 사라진다.
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ).pSymmetric(h: 20),
              const HeightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  '내용'.text.black.size(18).make().pOnly(left: 20),
                ],
              ),
              const HeightBox(5),
              TextField(
                controller: _controllerContents,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                ),
              ).pSymmetric(h: 20),
              const HeightBox(40),
              OutlinedButton(
                onPressed: _sendMessage,
                child: '접수하기'.text.black.size(20).make(),
              ),
              const HeightBox(20),
            ],
          ),
        ),
      ),
    );
  }
}

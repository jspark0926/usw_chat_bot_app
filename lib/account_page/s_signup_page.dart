import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../w_layout/w_default_Layout.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String emailAddress = '';
  late String password = '';
  late String verifyPassword = '';

  void addCustomDocument(String email) async {
    String collectionName = 'inquire';
    String customDocumentId = email;
    Map<String, dynamic> userData = {
      'email': emailAddress,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await addDocumentWithCustomId(collectionName, customDocumentId, userData);
    print('Document added with custom ID.');
  }

  Future<void> addDocumentWithCustomId(String collection, String documentId, Map<String, dynamic> data) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection(collection).doc(documentId).set(data);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      loginState: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const HeightBox(150),
            '수정상'.text.black.bold.size(80).make(),
            '수원대 정보 만물상'.text.black.bold.size(20).make(),
            const HeightBox(50),
            ///////////////////////////////////////////////////////////////////
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '이메일 입력'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            ///////////////////////////////////////////////////////////////////
            const HeightBox(10),
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
            const HeightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '비밀번호 입력'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            const HeightBox(10),
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
            const HeightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                '비밀번호 확인'.text.black.bold.size(20).make().pOnly(left: 20),
              ],
            ),
            HeightBox(10),
            TextField(
              onChanged: (text) {
                setState(() {
                  verifyPassword = text;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),

                labelText: 'Password',
              ),
            ).pSymmetric(h: 20),
            const HeightBox(50),
            OutlinedButton(onPressed: () async {
              if (password == verifyPassword){
                try {
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailAddress,
                    password: password,
                  );
                  await FirebaseAuth.instance.signOut();
                  addCustomDocument(emailAddress);
                  Navigator.pop(context);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '비밀번호가 보안에 취약합니다\n다시 입력해주세요'.text.bold.white.size(20).make(),
                      ),
                    );
                  } else if (e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: '이미 등록된 이메일입니다'.text.bold.white.size(20).make(),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: '오류가 발생하였습니다.\n고객센터에 문의 부탁드립니다.\n$e'.text.bold.white.size(20).make(),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: '비빌번호가 다릅니다'.text.bold.white.size(20).make(),
                  ),
                );
              }
            }, child: '저장'.text.black.bold.size(20).make())
          ],
        ),
      ),
    );
  }
}

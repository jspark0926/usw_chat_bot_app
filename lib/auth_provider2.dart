import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider2 extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // AuthProvider2();

  // 사용자 상태 반환
  User? get user => _auth.currentUser;

  // 인증 상태 변경을 감지하고 UI 업데이트
  void updateUser() {
    notifyListeners();
  }

  // 로그인 함수
  Future<void> signIn() async {
    // Firebase 로그인 로직
  }

  // 로그아웃 함수
  Future<void> signOut() async {
    // Firebase 로그아웃 로직
  }
}
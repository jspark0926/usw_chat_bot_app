import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 사용자 상태 반환
  User? get user => _auth.currentUser;

  // 인증 상태 변경을 감지하고 UI 업데이트
  void updateUser() {
    notifyListeners();
  }

  Future<void> VerifyBeforeUpdateEmail(String email) async {
    await user?.verifyBeforeUpdateEmail(email);
  }

  Future<void> reauthenticate(String email, String password) async {
    if (user != null) {
      final cred = EmailAuthProvider.credential(email: email, password: password);
      await user!.reauthenticateWithCredential(cred);
    }
  }

  // 로그인 함수
  Future<void> signIn() async {
    // Firebase 로그인 로직
  }

  // 로그아웃 함수
  Future<void> signOut() async {
    // Firebase 로그아웃 로직
  }

  Future<void> passwordUpdate(password) async {
    User? _user = _auth.currentUser;
    if (_user != null) {
      await _user.updatePassword(password);
    }
  }

  Future<void> passwordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create w_text_field_design.dart new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
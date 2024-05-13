import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider2 extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late var password = '';

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

  Future<void> passwordUpdate(password) async {
    User? _user = _auth.currentUser;
    if (_user != null) {
      await _user.updatePassword(password);
    }
  }

  Future<void> passwordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


}
// Logger logger = Logger();
//
// class FirebaseProvider with ChangeNotifier {
//   final FirebaseAuth fAuth = FirebaseAuth.instance; // Firebase 인증 플러그인의 인스턴스
//   FirebaseUser _user; // Firebase에 로그인 된 사용자
//
//   String _lastFirebaseResponse = ""; // Firebase로부터 받은 최신 메시지(에러 처리용)
//
//   FirebaseProvider() {
//     logger.d("init FirebaseProvider");
//     _prepareUser();
//   }
//
//   FirebaseUser getUser() {
//     return _user;
//   }
//
//   void setUser(FirebaseUser value) {
//     _user = value;
//     notifyListeners();
//   }
//
//   // 최근 Firebase에 로그인한 사용자의 정보 획득
//   _prepareUser() {
//     fAuth.currentUser().then((FirebaseUser currentUser) {
//       setUser(currentUser);
//     });
//   }
//
//   // 이메일/비밀번호로 Firebase에 회원가입
//   Future<bool> signUpWithEmail(String email, String password) async {
//     try {
//       AuthResult result = await fAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (result.user != null) {
//         // 인증 메일 발송
//         result.user.sendEmailVerification();
//         // 새로운 계정 생성이 성공하였으므로 기존 계정이 있을 경우 로그아웃 시킴
//         signOut();
//         return true;
//       }
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       List<String> result = e.toString().split(", ");
//       setLastFBMessage(result[1]);
//       return false;
//     }
//   }
//
//   // 이메일/비밀번호로 Firebase에 로그인
//   Future<bool> signInWithEmail(String email, String password) async {
//     try {
//       var result = await fAuth.signInWithEmailAndPassword(
//           email: email, password: password);
//       if (result != null) {
//         setUser(result.user);
//         logger.d(getUser());
//         return true;
//       }
//       return false;
//     } on Exception catch (e) {
//       logger.e(e.toString());
//       List<String> result = e.toString().split(", ");
//       setLastFBMessage(result[1]);
//       return false;
//     }
//   }
//
//   // Firebase로부터 로그아웃
//   signOut() async {
//     await fAuth.signOut();
//     setUser(null);
//   }
//
//   // 사용자에게 비밀번호 재설정 메일을 영어로 전송 시도
//   sendPasswordResetEmailByEnglish() async {
//     await fAuth.setLanguageCode("en");
//     sendPasswordResetEmail();
//   }
//
//   // 사용자에게 비밀번호 재설정 메일을 한글로 전송 시도
//   sendPasswordResetEmailByKorean() async {
//     await fAuth.setLanguageCode("ko");
//     sendPasswordResetEmail();
//   }
//
//   // 사용자에게 비밀번호 재설정 메일을 전송
//   sendPasswordResetEmail() async {
//     fAuth.sendPasswordResetEmail(email: getUser().email);
//   }
//
//   // Firebase로부터 회원 탈퇴
//   withdrawalAccount() async {
//     await getUser().delete();
//     setUser(null);
//   }
//
//   // Firebase로부터 수신한 메시지 설정
//   setLastFBMessage(String msg) {
//     _lastFirebaseResponse = msg;
//   }
//
//   // Firebase로부터 수신한 메시지를 반환하고 삭제
//   getLastFBMessage() {
//     String returnValue = _lastFirebaseResponse;
//     _lastFirebaseResponse = null;
//     return returnValue;
//   }
// }
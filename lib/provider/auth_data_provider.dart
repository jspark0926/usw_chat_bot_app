import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  AuthDataProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> verifyBeforeUpdateEmail(String email) async {
    if (user != null) {
      try {
        await _auth.setLanguageCode("en");
        await user!.verifyBeforeUpdateEmail(email);
        print('verifyBeforeUpdateEmail success: $email');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          throw FirebaseAuthException(
              code: 'requires-recent-login',
              message: 'This operation is sensitive and requires recent authentication. Log in again before retrying this request.');
        } else {
          rethrow;
        }
      }
    }
  }

  Future<void> reauthenticate(String email, String password) async {
    if (user != null) {
      try {
        final cred = EmailAuthProvider.credential(email: email, password: password);
        await user!.reauthenticateWithCredential(cred);
        print('Reauthentication success');
      } catch (e) {
        print('Reauthentication failed: $e');
        rethrow;
      }
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
      print('Sign-in successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw FirebaseAuthException(
            code: 'user-not-found', message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw FirebaseAuthException(
            code: 'wrong-password', message: 'Wrong password provided.');
      } else {
        rethrow;
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> passwordUpdate(String password) async {
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
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      notifyListeners();
      return userCredential;
    }
    throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
  }
}

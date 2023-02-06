import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthService {
  Future<void> signIn(String email, String password);
  Future<void> signUp(String name, String email, String password,
      String phoneNumber, String birth);
  Future signInWithGoogle();
  Future<void> signInAnonymously();
  Future<void> signOut();
}

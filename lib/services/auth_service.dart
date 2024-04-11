import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<User?> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Đã có lỗi xảy ra");
    }
    return null;
  }

  Future<User?> signUpWithEmailPassword(String email, password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return credential.user;
    } on FirebaseAuthException catch (e) {
      print("Đã có lỗi xảy ra");
    }
  }

  // Future<void> signOut() async {
  //   return await _firebaseAuth.signOut();
  // }
}

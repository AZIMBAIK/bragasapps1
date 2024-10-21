import 'package:firebase_auth/firebase_auth.dart';

class Authserviceadmin {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> loginbyEmail({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }
}

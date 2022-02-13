import 'package:firebase_auth/firebase_auth.dart';

final authService = new Auth(FirebaseAuth.instance);

class Auth {
  //Autenticacion en firebase
  final FirebaseAuth _firebaseAuth;
  UserCredential user;

  Auth(this._firebaseAuth, [this.user]);

  Future<bool> signIn(String email, String password) async {
    try {
      this.user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      print(e.message);

      return false;
    }
  }

  //SignOut
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);

      return false;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get current user
  User ? getCurrentUser () {
    return _auth.currentUser;
  }

  // sign in
  Future<UserCredential> signIn({
    required String Email,
    required password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: Email,
        password: password,
      );
      // save the user in the collectiion 'User'
    _firestore.collection("Users").doc(userCredential.user!.uid).set(
      {"email" : Email,
       "uid" : userCredential.user!.uid,
      }
    );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // sign up
  Future<UserCredential> signUp({
    required String Email,
    required password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: Email, password: password);
      // save the user in the collectiion 'User'
      _firestore.collection("Users").doc(userCredential.user!.uid).set({
        "email": Email,
        "uid": userCredential.user!.uid,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  // sign out

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> sendPasswordReset(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(final String email, final String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    	if (e.code == 'user-not-found') {
      	   throw Exception('No user found for email' + email); 
    	}
    	if (e.code == 'wrong-password') {
    	   throw Exception('Wrong password provided for ' + email);
    	}
    }

    return _firebaseAuth.currentUser.uid;
  }

  Future<String> signUp(final String email, final String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
    } if (e.code == 'email-already-in-use') {
    	throw Exception('The account already exists for ' + email);
    }

    return _firebaseAuth.currentUser.uid;
  }


  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }


  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  
  
// TODO:
//  replace the commented code with https://firebase.flutter.dev/docs/auth/usage/
/*
  Future<void> sendEmailVerification() async {
    User user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  Future<void> sendPasswordReset(String email) async {
    _firebaseAuth.sendPasswordResetEmail(email: email);
  }*/
}

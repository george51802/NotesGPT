import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginException implements Exception {
  final String message;

  LoginException(this.message);
}

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw LoginException('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      throw LoginException('Password is incorrect.');
    }
    throw LoginException(e.message!);
  } catch (e) {
    throw LoginException(e.toString());
  }
}

class RegistrationException implements Exception {
  final String message;

  RegistrationException(this.message);
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      throw RegistrationException('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      throw RegistrationException('The account already exists for that email.');
    }
    throw RegistrationException(e.message!);
  } catch (e) {
    throw RegistrationException(e.toString());
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:relawanin_mobile_project/Models/userModel.dart';
import 'package:logger/logger.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger logger = Logger();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing in: $e");
      return null;
    }
  }

  Future<User?> registerUser(
    String email,
    String password,
    String username,
    String confirmPassword,
    String role,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'username': username,
          'password': password,
          'confirmPassword': confirmPassword,
          'role': 'relawan',
        });
      } catch (e) {
        logger.e("Error registering user: $e");
        return null;
      }
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing in: $e");
      return null;
    }
  }
}

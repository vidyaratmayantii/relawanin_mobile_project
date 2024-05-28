import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UserController {
  final picker = ImagePicker();

  Future<User?> getLogInUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      print('Error getting logged in user: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser() async {
    try {
      User? user = await getLogInUser();
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        if (snapshot.exists) {
          Map<String, dynamic>? userData = snapshot.data();
          return userData;
        }
        Map<String, dynamic>? userData = null;
        return userData;
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> updateData(Map<String, dynamic> userData) async {
    try {
      User? user = await getLogInUser();
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(userData);
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  Future<String?> uploadImageToFirebase(
      BuildContext context, String uid) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('images')
            .child(uid)
            .child('$imageName.jpg');
        UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        return downloadURL;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('No image selected')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload image')));
    }
    return null;
  }

  Future<void> saveProfileImage(String imageUrl) async {
    try {
      User? user = await getLogInUser();
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'profilePic': imageUrl});
      }
    } catch (e) {
      print('Error saving profile image: $e');
    }
  }
}

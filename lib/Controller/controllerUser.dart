import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {

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
}

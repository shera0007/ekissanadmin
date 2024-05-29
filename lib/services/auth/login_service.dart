import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> authenticateUser(String email, String password) async {
    try {
      // Check if the user is a subadmin
      QuerySnapshot subadminSnapshot = await _firestore.collection('subadmins').where('email', isEqualTo: email).get();
      if (subadminSnapshot.docs.isNotEmpty) {
        return subadminSnapshot.docs.first['password'] == password;
      }

      // If not a subadmin, return false
      return false;
    } catch (error) {
      print('Error authenticating user: $error');
      return false;
    }
  }
}

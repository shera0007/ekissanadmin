import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _subAdminsCollection =
      FirebaseFirestore.instance.collection('subadmins');

  Future<String?> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     
      String userId = userCredential.user!.uid;

      await _subAdminsCollection.doc(userId).set({
        'username': username,
        'email': email,
        'password': password
        
      });

      return userId;
    } catch (error) {
      print("Failed to sign up: $error");
      return null;
    }
  }
}

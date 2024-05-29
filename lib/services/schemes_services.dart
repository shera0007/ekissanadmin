import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SchemeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addScheme(
      String schemeNameEng, String schemeNameUrdu, String detailsEng, String detailsUrdu, File image,) async {
    try {
      String imagePath = await uploadImage(image);
      await _firestore.collection('schemes').add({
        'schemeNameEng': schemeNameEng,
        'schemeNameUrdu': schemeNameUrdu,
        'detailsEng': detailsEng,
        'detailsUrdu': detailsUrdu,
        'imagePath': imagePath,
      });
    } catch (e) {
      print('Error adding scheme to Firestore: $e');
      throw e;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('scheme_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  Future<void> updateScheme(
    String schemeId,
    String schemeNameEng,
    String schemeNameUrdu,
    String detailsEng,
    String detailsUrdu,
    String? imagePath,
  ) async {
    try {
      final data = {
        'schemeNameEng': schemeNameEng,
        'schemeNameUrdu': schemeNameUrdu,
        'detailsEng': detailsEng,
        'detailsUrdu': detailsUrdu,
      };

      if (imagePath != null) {
        data['imagePath'] = imagePath;
      }

      await _firestore.collection('schemes').doc(schemeId).update(data);
    } catch (e) {
      print('Error updating scheme: $e');
      throw e;
    }
  }
}

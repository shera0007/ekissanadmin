import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CropService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveCropData(
    String cropNameEng,
    String cropNameUrdu,
    String typeEng,
    String typeUrdu,
    String detailsEng,
    String detailsUrdu,
    File image,
  ) async {
    try {
      // Upload image to Firebase Storage
      String imagePath = await uploadImage(image);

      // Save crop data to Firestore
      await _firestore.collection('crops').add({
        'cropNameEng': cropNameEng,
        'typeEng': typeEng,
        'discriptionEng': detailsEng,
        'cropNameUrdu': cropNameUrdu,
        'typeUrdu': typeUrdu,
        'discriptionUrdu': detailsUrdu,
        'imagePath': imagePath,
      });
    } catch (e) {
      print('Error saving crop data: $e');
      throw e;
    }
  }

  Future<void> updateCropData(
    String cropId,
    String cropNameEng,
    String cropNameUrdu,
    String typeEng,
    String typeUrdu,
    String detailsEng,
    String detailsUrdu,
    File? image,
  ) async {
    try {
      // Upload image to Firebase Storage if a new image is provided
      String? imagePath;
      if (image != null) {
        imagePath = await uploadImage(image);
      }

      // Update crop data in Firestore
      Map<String, dynamic> cropData = {
        'cropNameEng': cropNameEng,
        'typeEng': typeEng,
        'discriptionEng': detailsEng,
        'cropNameUrdu': cropNameUrdu,
        'typeUrdu': typeUrdu,
        'discriptionUrdu': detailsUrdu,
      };

      if (imagePath != null) {
        cropData['imagePath'] = imagePath;
      }

      await _firestore.collection('crops').doc(cropId).update(cropData);
    } catch (e) {
      print('Error updating crop data: $e');
      throw e;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('crop_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
}

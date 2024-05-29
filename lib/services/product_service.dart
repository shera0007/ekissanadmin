import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadProduct(
    String name,
    double price,
    File image,
    double discount,
    bool isGovernmentScheme,
    double stock,
  ) async {
    try {
      // Upload image to Firebase Storage
      String imagePath = await uploadImage(image);

      // Save product data to Firestore
      await _firestore.collection('products').add({
        'name': name,
        'price': price,
        'imagePath': imagePath,
        'discount': discount,
        'isGovernmentScheme': isGovernmentScheme,
        'stock': stock,
      });
    } catch (e) {
      print('Error saving product data: $e');
      throw e;
    }
  }

  Future<void> updateProduct(
    String productId,
    String name,
    double price,
    File? image,
    double discount,
    bool isGovernmentScheme,
    double stock,
  ) async {
    try {
      // Upload image to Firebase Storage if a new image is provided
      String? imagePath;
      if (image != null) {
        imagePath = await uploadImage(image);
      }

      // Update product data in Firestore
      Map<String, dynamic> productData = {
        'name': name,
        'price': price,
        'discount': discount,
        'isGovernmentScheme': isGovernmentScheme,
        'stock': stock,
      };

      if (imagePath != null) {
        productData['imagePath'] = imagePath;
      }

      await _firestore.collection('products').doc(productId).update(productData);
    } catch (e) {
      print('Error updating product data: $e');
      throw e;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('product_images')
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

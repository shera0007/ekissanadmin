import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ekissanadmin/services/schemes_services.dart';

class SchemeController extends GetxController {
  final SchemeService _schemeService = SchemeService();

  final formKey = GlobalKey<FormState>();
  final TextEditingController schemeNameEngController = TextEditingController();
  final TextEditingController schemeNameUrduController = TextEditingController();
  final TextEditingController detailsEngController = TextEditingController();
  final TextEditingController detailsUrduController = TextEditingController();
  final Rx<File?> image = Rx<File?>(null);

  RxBool isLoading = false.obs;

  Future<void> uploadImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "Select Image Source",
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Colors.black),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.camera);
              },
              child: Text("Take a Photo"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(ImageSource.gallery);
              },
              child: Text("Choose from Gallery"),
            ),
          ],
        ),
      ),
    );

    if (imageSource != null) {
      final pickedImage = await picker.pickImage(
        source: imageSource,
        imageQuality: 50,
      );

      if (pickedImage != null) {
        image.value = File(pickedImage.path);
      } else {
        Get.snackbar('Error', 'Please Select an Image',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> addScheme() async {
    if (image.value == null) {
      isLoading.value = false;
      Get.snackbar('Error', 'Please upload an image',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP);
      return;
    }

    String schemeNameEng = schemeNameEngController.text;
    String schemeNameUrdu = schemeNameUrduController.text;
    String detailsEng = detailsEngController.text;
    String detailsUrdu = detailsUrduController.text;

    try {
    
      isLoading.value = true;

      await _schemeService.addScheme(
        schemeNameEng,
        schemeNameUrdu,
        detailsEng,
        detailsUrdu,
        image.value!,
      );

  
      Get.snackbar(
        'Success',
        'Scheme has been added successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
     
      print('Error adding scheme: $e');
    } finally {
      
      isLoading.value = false;
    }
  }

  Future<void> updateScheme(String schemeId) async {
    String schemeNameEng = schemeNameEngController.text;
    String schemeNameUrdu = schemeNameUrduController.text;
    String detailsEng = detailsEngController.text;
    String detailsUrdu = detailsUrduController.text;

    try {
   
      isLoading.value = true;

      String? imagePath;
      if (image.value != null) {
        imagePath = await _schemeService.uploadImage(image.value!);
      }

      await _schemeService.updateScheme(
        schemeId,
        schemeNameEng,
        schemeNameUrdu,
        detailsEng,
        detailsUrdu,
        imagePath,
      );

      // Show Snackbar indicating successful update
      Get.snackbar(
        'Success',
        'Scheme has been updated successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      // Add a slight delay before calling Get.back()
      await Future.delayed(Duration(seconds: 1));
      Get.back(); 
    } catch (e) {
     
      print('Error updating scheme: $e');
      Get.snackbar(
        'Error',
        'Failed to update scheme',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
    
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
   
    schemeNameEngController.dispose();
    schemeNameUrduController.dispose();
    detailsEngController.dispose();
    detailsUrduController.dispose();
    super.dispose();
  }
}

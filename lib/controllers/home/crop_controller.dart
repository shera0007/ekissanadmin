import 'dart:io';
import 'package:ekissanadmin/screens/home/crops/all_crops.dart';
import 'package:ekissanadmin/services/crop_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CropController extends GetxController {
  final TextEditingController cropNameEngController = TextEditingController();
  final TextEditingController typeEngController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController detailsEngController = TextEditingController();
  final TextEditingController cropNameUrduController = TextEditingController();
  final TextEditingController typeUrduController = TextEditingController();
  final TextEditingController detailsUrduController = TextEditingController();
  final CropService _cropService = CropService();
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

  Future<void> addCrop() async {
    

      String cropNameEng = cropNameEngController.text;
      String typeEng = typeEngController.text;
      String detailsEng = detailsEngController.text;
      String cropNameUrdu = cropNameUrduController.text;
      String typeUrdu = typeUrduController.text;
      String detailsUrdu = detailsUrduController.text;

      if (image.value == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Please upload an image',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP);
        return;
      }

      try {
        await _cropService.saveCropData(
          cropNameEng,
          cropNameUrdu,
          typeEng,
          typeUrdu,
          detailsEng,
          detailsUrdu,
          image.value!,
        );

        Get.snackbar(
          'Success',
          'Crop has been added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        cropNameEngController.clear();
        cropNameUrduController.clear();
        detailsEngController.clear();
        detailsUrduController.clear();
        typeUrduController.clear();
        typeEngController.clear();
        image.value = null;
        Get.to(() => AllCrops());
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('Error', 'Failed to save crop data');
        print('Error saving crop data: $e');
      } finally {
        isLoading.value = false;
      }
    
  }

  Future<void> updateCrop(String cropId) async {
    // if (!formKey.currentState!.validate()) {
    //   return;
    // }

    isLoading.value = true;

    try {
      await _cropService.updateCropData(
        cropId,
        cropNameEngController.text,
        cropNameUrduController.text,
        typeEngController.text,
        typeUrduController.text,
        detailsEngController.text,
        detailsUrduController.text,
        image.value,
      );

      Get.snackbar(
        'Success',
        'Crop has been updated successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      Get.to(() => AllCrops());
    } catch (e) {
      Get.snackbar('Error', 'Failed to update crop data');
      print('Error updating crop data: $e');
    } finally {
      isLoading.value = false;
    }
  }



}

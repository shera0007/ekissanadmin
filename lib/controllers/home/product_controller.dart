import 'dart:io';

import 'package:ekissanadmin/screens/home/products/all_products.dart';
import 'package:ekissanadmin/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<File?> image = Rx<File?>(null);
  final RxBool isGovernmentScheme = false.obs;
  final RxBool isLoading = false.obs;

  final ProductService productService = ProductService();

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
              .headline6
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
        Get.snackbar('Error', 'Please select an image',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  void addProduct() async {
   
      isLoading.value = true;
      String name = productNameController.text;
      double price = double.parse(priceController.text);
      double discount = isGovernmentScheme.value
          ? double.parse(discountController.text)
          : 0.0;
      double stock = double.parse(stockController.text);

      if (image.value == null) {
        isLoading.value = false;
        Get.snackbar('Error', 'Please upload an image',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP);
        return;
      }

      try {
        await productService.uploadProduct(
          name,
          price,
          image.value!,
          discount,
          isGovernmentScheme.value,
          stock,
        );

        Get.snackbar(
          'Success',
          'Product added successfully!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );

        productNameController.clear();
        priceController.clear();
        discountController.clear();
        stockController.clear();
        image.value = null;

        Get.to(() => AllProducts());
      } catch (e) {
        Get.snackbar('Error', 'Failed to add product: $e',
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP);
        print('Error adding product: $e');
      } finally {
        isLoading.value = false;
      }
    }
  

  void updateProduct(String productId) async {
    isLoading.value = true;
    String name = productNameController.text;
    double price = double.parse(priceController.text);
    double discount =
        isGovernmentScheme.value ? double.parse(discountController.text) : 0.0;
    double stock = double.parse(stockController.text);

    if (image.value == null) {
      isLoading.value = false;
      Get.snackbar('Error', 'Please upload an image',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      await productService.updateProduct(
        productId,
        name,
        price,
        image.value!,
        discount,
        isGovernmentScheme.value,
        stock,
      );

      Get.snackbar(
        'Success',
        'Product updated successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      productNameController.clear();
      priceController.clear();
      discountController.clear();
      stockController.clear();
      image.value = null;

      Get.to(() => AllProducts());
    } catch (e) {
      Get.snackbar('Error', 'Failed to update product: $e',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          snackPosition: SnackPosition.TOP);
      print('Error updating product: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void dispose() {
    Get.back();
    super.dispose();
  }
}

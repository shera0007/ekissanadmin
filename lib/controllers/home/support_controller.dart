import 'package:ekissanadmin/models/support.dart';
import 'package:ekissanadmin/services/supoort_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SupportController extends GetxController {
  final SupportService _supportService = SupportService();

  final formKey = GlobalKey<FormState>();
  final TextEditingController topicEngController = TextEditingController();
  final TextEditingController topicUrduController = TextEditingController();
  final TextEditingController descriptionEngController = TextEditingController();
  final TextEditingController descriptionUrduController = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> addSupportTopic() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String topicEng = topicEngController.text;
    String topicUrdu = topicUrduController.text;
    String descriptionEng = descriptionEngController.text;
    String descriptionUrdu = descriptionUrduController.text;

    try {
      isLoading.value = true;

      SupportTopic topic = SupportTopic(
        topicEng: topicEng,
        topicUrdu: topicUrdu,
        descriptionEng: descriptionEng,
        descriptionUrdu: descriptionUrdu,
      );

      await _supportService.addSupportTopic(topic);

      Get.snackbar(
        'Success',
        'Support topic has been added successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('Error adding support topic: $e');
      Get.snackbar(
        'Error',
        'Failed to add support topic',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateSupportTopic(String id) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String topicEng = topicEngController.text;
    String topicUrdu = topicUrduController.text;
    String descriptionEng = descriptionEngController.text;
    String descriptionUrdu = descriptionUrduController.text;

    try {
      isLoading.value = true;

      SupportTopic topic = SupportTopic(
        topicEng: topicEng,
        topicUrdu: topicUrdu,
        descriptionEng: descriptionEng,
        descriptionUrdu: descriptionUrdu,
      );

      await _supportService.updateSupportTopic(id, topic);

      Get.snackbar(
        'Success',
        'Support topic has been updated successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );

      Get.back();
    } catch (e) {
      print('Error updating support topic: $e');
      Get.snackbar(
        'Error',
        'Failed to update support topic',
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
    topicEngController.dispose();
    topicUrduController.dispose();
    descriptionEngController.dispose();
    descriptionUrduController.dispose();
    super.dispose();
  }
}

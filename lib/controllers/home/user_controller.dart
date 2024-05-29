import 'package:ekissanadmin/screens/home/users/all_users.dart';
import 'package:ekissanadmin/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserController extends GetxController {
  final UserService _firebaseService = UserService();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> addUser() async {
    isLoading.value = true;
    try {
      String? userId = await _firebaseService.signUpWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
        usernameController.text.trim(),
      );
      if (userId != null) {
        formKey.currentState?.reset();
         Get.offAll(() => AllUsers());
      } else {
        
      }
    } finally {
      isLoading.value = false;
    }
  }
}

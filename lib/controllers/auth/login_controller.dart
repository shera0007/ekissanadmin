import 'package:ekissanadmin/services/auth/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ekissanadmin/screens/home/dashboard_screen.dart';


class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String adminEmail = 'shera@gmail.com';
  final String adminPassword = '112233';

  final AuthService _authService = AuthService();

  void loginUser() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email == adminEmail && password == adminPassword) {
      Get.off(() => DashboardScreen());
      print('Admin logged in successfully');
    } else {
      bool isSubadminAuthenticated = await _authService.authenticateUser(email, password);
      if (isSubadminAuthenticated) {
        Get.off(() => DashboardScreen());
        print('Subadmin logged in successfully');
      } else {
        Get.snackbar(
          'Error',
          'Invalid email or password.',
          backgroundColor: Colors.red,
        );
      }
    }
  }
}

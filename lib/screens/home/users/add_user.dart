import 'package:ekissanadmin/controllers/home/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ekissanadmin/screens/home/users/all_users.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';

class AddUserScreen extends StatelessWidget {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Add User'),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Add User',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ),
                SizedBox(height: 30),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: _userController.usernameController,
                  headingText: 'Username',
                  hintText: 'Enter your username',
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Please enter your Username';
                      }
                    }
                    return null;
                  },
                  borderColor: Colors.orange,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _userController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  headingText: 'E-mail',
                  hintText: 'Enter email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  borderColor: Colors.blue,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: _userController.passwordController,
                  headingText: 'Password',
                  hintText: 'Enter your password',
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                    }
                    return null;
                  },
                  obscureText: true,
                  borderColor: Colors.green,
                ),
                SizedBox(height: 76),
                Center(
                  child: Column(
                    children: [
                      GreenButton(
                        buttonText: "Add User",
                        onPressedFunction: () {
                          _userController.addUser();
                        },
                        context: context,
                      ),
                      SizedBox(height: 30),
                      InkWell(
                        highlightColor: Color(0xFF34A853),
                        onTap: () {
                          Get.to(() => AllUsers());
                        },
                        child: Text(
                          'Show All Users',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  color: Color(0xFF34A853),
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                // Loading indicator
                if (_userController.isLoading.value)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

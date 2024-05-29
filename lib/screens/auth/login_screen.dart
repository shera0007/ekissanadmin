
import 'package:ekissanadmin/controllers/auth/login_controller.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Text(
                  'Login as Admin',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.black),
                ),
                SizedBox(height: 30.h),
                CustomTextField(
                  controller: _loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  headingText: 'E-mail',
                  hintText: 'Enter your email',
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
                SizedBox(height: 16.h),
                CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: _loginController.passwordController,
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
                SizedBox(height: 30.h),
                Center(
                  child: InkWell(
                    highlightColor: Color(0xFF34A853),
                    onTap: () {
                    //  Get.to(() => FPScreen());
                    },
                    child: Text('Forget Password?',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Color(0xFF34A853))),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                    child: Column(
                  children: [
                    GreenButton(
                        buttonText: "Login",
                        onPressedFunction: () {
                          if (_loginController.formKey.currentState
                                  ?.validate() ??
                              false) {
                            _loginController.loginUser();
                          }
                        },
                        context: context),
                    SizedBox(height: 30.h),             
                   
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

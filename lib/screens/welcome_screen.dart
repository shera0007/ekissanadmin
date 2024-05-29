

import 'package:ekissanadmin/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome.jpeg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Padding(
            padding: const EdgeInsets.all(26),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    'Welcome to',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white, fontSize: 40, fontFamily: 'Aoboshi'),
                  ),
                  Text(
                    'E-Kissan',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Color(0xFF34A853),
                        letterSpacing: 2,
                        fontSize: 40.sp,
                        fontFamily: 'Aoboshi'),
                  ),
                  SizedBox(height: 300.h),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1.5.w,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                          ),
                          child: Text(
                            'Sign In with',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1.5.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    height: 40.h,
                    width: 400.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(30)),
                    child: ElevatedButton(
                      onPressed: () {
                       Get.to(() => LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          textStyle:
                              TextStyle(fontFamily: 'Alatsi', fontSize: 16.sp)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text('Start with Email'),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

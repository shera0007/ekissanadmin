
import 'package:ekissanadmin/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Get.off(() => WelcomeScreen()); 
      },
    );

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF34A853),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'E-Kissan',
                 style: Theme.of(context).textTheme.displayLarge?.copyWith(color: Colors.white, letterSpacing: 2),
              ),
              //SizedBox(height: 8.h),
              Image.asset('assets/images/logo.png', height: 100.h),
                          
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:ekissanadmin/screens/home/crops/add_crop.dart';
import 'package:ekissanadmin/screens/home/products/add_product.dart';
import 'package:ekissanadmin/screens/home/schemes/add_scheme.dart';
import 'package:ekissanadmin/screens/home/users/add_user.dart';
import 'package:ekissanadmin/screens/home/form_screen.dart';
import 'package:ekissanadmin/screens/home/support._screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Admin Dashboard',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                // Sign out the user
                try {
                  await FirebaseAuth.instance.signOut();
                  // Navigate to the login screen or any other screen you want
                  // Here I'm assuming you have a named route for your login screen
                  Get.back();
                } catch (e) {
                  // Handle sign out errors
                  print('Error signing out: $e');
                  // Optionally, you can show a snackbar or dialog to inform the user
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                'assets/images/logo.png',
                height: 100.h,
              ),
              Text(
                'E-Kissan',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.green, letterSpacing: 2),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildContainer('Users', () {
                    Get.to(() => AddUserScreen());
                  }),
                  _buildContainer('Forms', () {
                    Get.to(() => FormScreen());
                  }),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildContainer('Schemes', () {
                    Get.to(() => AddSchemeScreen());
                  }),
                  _buildContainer('Products', () {
                    Get.to(() => AddProductScreen());
                  }),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildContainer('Crops', () {
                    Get.to(() => AddCropScreen());
                  }),
                  _buildContainer('Get Support', () {
                    Get.to(() => SupportScreen());
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 75.h,
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Sans',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

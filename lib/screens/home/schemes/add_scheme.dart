import 'package:ekissanadmin/controllers/home/schemes_controller.dart';
import 'package:ekissanadmin/screens/home/schemes/all_schemes.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddSchemeScreen extends StatelessWidget {
  final SchemeController schemeController = Get.put(SchemeController());
  
  @override
  Widget build(BuildContext context) {
    return Form(
      //key: schemeController.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          title: Text(''),
          centerTitle: true,
        ),
        body: Obx(() {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        'Add Scheme',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        controller: schemeController.schemeNameEngController,
                        headingText: 'Scheme Name in English',
                        hintText: 'Enter Scheme name',
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Please enter scheme name';
                            }
                          }

                          return null;
                        },
                        borderColor: Colors.orange,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        controller: schemeController.schemeNameUrduController,
                        headingText: 'Scheme Name in Urdu',
                        hintText: 'Enter Scheme name',
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Please enter scheme name';
                            }
                          }

                          return null;
                        },
                        borderColor: Colors.orange,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        controller: schemeController.detailsEngController,
                        headingText: 'Details in English',
                        hintText: 'Enter details.....',
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Please enter some details';
                            }
                          }

                          return null;
                        },
                        borderColor: Colors.blue,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.text,
                        controller: schemeController.detailsUrduController,
                        headingText: 'Details in Urdu',
                        hintText: 'Enter details.....',
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Please enter some details';
                            }
                          }

                          return null;
                        },
                        borderColor: Colors.blue,
                      ),
                      SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      schemeController.uploadImage(context);
                    },
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Obx(() {
                          if (schemeController.image.value != null) {
                            return Image.file(schemeController.image.value!,
                                fit: BoxFit.cover);
                          } else {
                            return Icon(Icons.upload_rounded);
                          }
                        }),
                      ),
                    ),
                  ),
                      SizedBox(height: 76.h),
                      Center(
                        child: Column(
                          children: [
                            GreenButton(
                              buttonText: "Add Scheme",
                              onPressedFunction: () {
                                schemeController.addScheme();
                              },
                              context: context,
                            ),
                            SizedBox(height: 30.h),
                            InkWell(
                              highlightColor: Color(0xFF34A853),
                              onTap: () {
                                Get.to(() => AllSchemes());
                              },
                              child: Text(
                                'Show All Schemes',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: Color(0xFF34A853),
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Loading indicator
              if (schemeController.isLoading.value)
                Center(
                  child: Container(
                   // color: Colors.black.withOpacity(0.5),
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

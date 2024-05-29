import 'package:ekissanadmin/controllers/home/schemes_controller.dart';
import 'package:ekissanadmin/models/schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';

class UpdateSchemeScreen extends StatefulWidget {
  final Scheme scheme;

  UpdateSchemeScreen({required this.scheme});

  @override
  _UpdateSchemeScreenState createState() => _UpdateSchemeScreenState();
}

class _UpdateSchemeScreenState extends State<UpdateSchemeScreen> {
  final SchemeController schemeController = Get.put(SchemeController());
  late String imageUrl='';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      schemeController.schemeNameEngController.text = widget.scheme.schemeNameEng;
      schemeController.schemeNameUrduController.text = widget.scheme.schemeNameUrdu;
      schemeController.detailsEngController.text = widget.scheme.detailsEng;
      schemeController.detailsUrduController.text = widget.scheme.detailsUrdu;
      imageUrl = widget.scheme.imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: schemeController.formKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text('Update Scheme Info.'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: schemeController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    'Update Scheme Info.',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    controller: schemeController.schemeNameEngController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter scheme name in English';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Scheme Name (English)',
                    hintText: 'Enter scheme name in English',
                    borderColor: Colors.orange,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: schemeController.schemeNameUrduController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter scheme name in Urdu';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Scheme Name (Urdu)',
                    hintText: 'Enter scheme name in Urdu',
                    borderColor: Colors.blue,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: schemeController.detailsEngController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter scheme details in English';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Details (English)',
                    hintText: 'Enter scheme details in English',
                    borderColor: Colors.green,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: schemeController.detailsUrduController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter scheme details in Urdu';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Details (Urdu)',
                    hintText: 'Enter scheme details in Urdu',
                    borderColor: Colors.green,
                  ),
                  SizedBox(height: 20.h),
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
                            return imageUrl.isNotEmpty
                                ? Image.network(imageUrl, fit: BoxFit.cover)
                                : Icon(Icons.upload_rounded);
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
                          buttonText: "Update Scheme",
                          onPressedFunction: () {
                            schemeController.updateScheme(widget.scheme.id);
                          },
                          context: context,
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                  if (schemeController.isLoading.value)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

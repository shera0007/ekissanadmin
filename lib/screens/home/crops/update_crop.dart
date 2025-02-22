import 'package:ekissanadmin/models/crops.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ekissanadmin/controllers/home/crop_controller.dart';
import 'package:ekissanadmin/screens/home/crops/all_crops.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';

class UpdateCropScreen extends StatefulWidget {
  final Crop crop;

  UpdateCropScreen({required this.crop});

  @override
  _UpdateCropScreenState createState() => _UpdateCropScreenState();
}

class _UpdateCropScreenState extends State<UpdateCropScreen> {
  final CropController cropController = Get.find<CropController>();
    late String imageUrl;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cropController.cropNameEngController.text = widget.crop.cropNameEng;
      cropController.cropNameUrduController.text = widget.crop.cropNameUrdu;
      cropController.typeEngController.text = widget.crop.typeEng;
      cropController.typeUrduController.text = widget.crop.typeUrdu;
      cropController.detailsEngController.text = widget.crop.discriptionEng;
      cropController.detailsUrduController.text = widget.crop.discriptionUrdu;
      imageUrl = widget.crop.imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text('Update Crop Info.'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              //  key: cropController.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Text(
                    'Update Crop Info.',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    controller: cropController.cropNameEngController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter Crop name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Crop Name in English',
                    hintText: 'Enter Crop name',
                    borderColor: Colors.orange,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: cropController.cropNameUrduController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter Crop name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Crop Name in Urdu',
                    hintText: 'Enter Crop name',
                    borderColor: Colors.orange,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: cropController.typeEngController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter crop type';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Type in English',
                    hintText: 'Enter Crop type',
                    borderColor: Colors.green,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: cropController.typeUrduController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter crop type';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Type in Urdu',
                    hintText: 'Enter Crop type',
                    borderColor: Colors.green,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: cropController.detailsEngController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter some details';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Details in English',
                    hintText: 'Enter details.....',
                    borderColor: Colors.blue,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: cropController.detailsUrduController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Please enter some details';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    headingText: 'Details in Urdu',
                    hintText: 'Enter details.....',
                    borderColor: Colors.blue,
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      cropController.uploadImage(context);
                    },
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Obx(() {
                          if (cropController.image.value != null) {
                            return Image.file(cropController.image.value!,
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
                          buttonText: "Update Crop",
                          onPressedFunction: () {
                            cropController.updateCrop(
                                widget.crop.id); // Pass the crop ID here
                          },
                          context: context,
                        ),
                        SizedBox(height: 30.h),
                        InkWell(
                          highlightColor: Color(0xFF34A853),
                          onTap: () {
                            Get.to(() => AllCrops());
                          },
                          child: Text(
                            'Show All Crops',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    color: Color(0xFF34A853),
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cropController.isLoading.value)
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

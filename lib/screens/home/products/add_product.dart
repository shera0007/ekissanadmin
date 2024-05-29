import 'package:ekissanadmin/controllers/home/product_controller.dart';
import 'package:ekissanadmin/screens/home/products/all_products.dart';
import 'package:ekissanadmin/utils/widgets/buttons.dart';
import 'package:ekissanadmin/utils/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: productController.formKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(''),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add product',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.black),
              ),
              SizedBox(height: 30.h),
              CustomTextField(
                controller: productController.productNameController,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Please enter product name';
                    }
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                headingText: 'Product Name',
                hintText: 'Enter product name',
                borderColor: Colors.orange,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: productController.priceController,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Please enter product price';
                    }
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                headingText: 'Price',
                hintText: 'Enter Price of product',
                borderColor: Colors.blue,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                controller: productController.stockController,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return 'Please enter product stock';
                    }
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                headingText: 'Total Stock',
                hintText: 'Enter Stock',
                borderColor: Colors.blue,
              ),
              SizedBox(height: 26.h),
              Row(
                children: [
                  Text(
                    "Government Scheme",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  SizedBox(width: 16.w),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Switch(
                        value: productController.isGovernmentScheme.value,
                        onChanged: (value) {
                          setState(() {
                            productController.isGovernmentScheme.value = value;
                          });
                        },
                        activeColor: Colors.green,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Obx(() {
                if (productController.isGovernmentScheme.value) {
                  return CustomTextField(
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter product price';
                        }
                      }

                      return null;
                    },
                    controller: productController.discountController,
                    keyboardType: TextInputType.number,
                    headingText: 'Discount',
                    hintText: 'Enter discount',
                    borderColor: Colors.green,
                  );
                } else {
                  return SizedBox();
                }
              }),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  productController.uploadImage(context);
                },
                child: Center(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Obx(() {
                      if (productController.image.value != null) {
                        return Image.file(productController.image.value!,
                            fit: BoxFit.cover);
                      } else {
                        return Icon(Icons.upload_rounded);
                      }
                    }),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Column(
                  children: [
                    GreenButton(
                      buttonText: "Add Product",
                      onPressedFunction: () {
                        productController.addProduct();
                      },
                      context: context,
                    ),
                    SizedBox(height: 30.h),
                    Center(
                      child: InkWell(
                        highlightColor: Color(0xFF34A853),
                        onTap: () {
                          Get.to(() => AllProducts());
                        },
                        child: Text(
                          'Show All Products',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  color: Color(0xFF34A853),
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                if (productController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:ekissanadmin/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:ekissanadmin/screens/home/products/update_product.dart';


class AllProducts extends StatelessWidget {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(
          'Products List',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Products',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          'Name',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                        SizedBox(width: 50.w),
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    StreamBuilder<QuerySnapshot>(
                      stream: productsRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final products = snapshot.data?.docs ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: products.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            final product = Product.fromDocument(doc); 
                            return _buildProductListItem(product);
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductListItem(Product product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 20.h,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                product.name,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Container(
            width: 90.w,
            height: 20.h,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                product.price.toString(),
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Container(
            height: 20.h,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.w)),
              color: Colors.red,
              onPressed: () {
                _removeProduct(product.id);
              },
              child: Text('Remove'),
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            height: 20.h,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.w)),
              color: Colors.blue,
              onPressed: () {
                Get.to(() => UpdateProductScreen(product: product));
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeProduct(String productId) async {
    try {
      await productsRef.doc(productId).delete();
      Get.snackbar(
        'Success',
        'Product removed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('Error removing product: $e');
      Get.snackbar(
        'Error',
        'Failed to remove product',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}

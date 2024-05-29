import 'package:ekissanadmin/models/crops.dart';
import 'package:ekissanadmin/screens/home/crops/update_crop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCrops extends StatelessWidget {
  final CollectionReference cropsRef =
      FirebaseFirestore.instance.collection('crops');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(
          'Crop List',
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
                      'All Crops',
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
                          'Type',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    StreamBuilder<QuerySnapshot>(
                      stream: cropsRef.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        final crops = snapshot.data?.docs ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: crops.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            final crop = Crop.fromDocument(doc); // Create Crop object
                            return _buildCropListItem(crop);
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

  Widget _buildCropListItem(Crop crop) {
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
                crop.cropNameEng,
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
                crop.typeEng,
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
                _removeCrop(crop.cropNameEng);
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
                Get.to(() => UpdateCropScreen(crop: crop));
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeCrop(String cropName) async {
    try {
      await cropsRef
          .where('cropNameEng', isEqualTo: cropName)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
      Get.snackbar(
        'Success',
        'Crop removed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('Error removing crop: $e');
      Get.snackbar(
        'Error',
        'Failed to remove crop',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}

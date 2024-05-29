import 'package:ekissanadmin/models/schemes.dart';
import 'package:ekissanadmin/screens/home/schemes/update_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AllSchemes extends StatelessWidget {
  final CollectionReference schemesRef =
      FirebaseFirestore.instance.collection('schemes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(
          'Schemes List',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Schemes',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.black),
              ),
              SizedBox(height: 10.h),
              StreamBuilder<QuerySnapshot>(
                stream: schemesRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final schemes = snapshot.data?.docs ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: schemes.map((doc) {
                      final scheme = Scheme.fromDocument(doc);
                      return _buildSchemeListItem(context, scheme);
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSchemeListItem(BuildContext context, Scheme scheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 90.w,
            height: 20.h,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                scheme.schemeNameEng,
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
                _removeScheme(scheme.id);
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
                Get.to(()=>UpdateSchemeScreen(scheme: scheme));
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeScheme(String schemeId) async {
    try {
      await schemesRef.doc(schemeId).delete();
      Get.snackbar(
        'Success',
        'Scheme removed successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      print('Error removing scheme: $e');
      Get.snackbar(
        'Error',
        'Failed to remove scheme',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}

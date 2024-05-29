import 'package:ekissanadmin/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back))
        ],
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: Text(
          'Users List',
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
                      'All Users',
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
                          'Email',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('subadmins')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        final users = snapshot.data?.docs ?? [];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: users.map((doc) {
                            final userName = doc['username'] as String? ?? '';
                            final userEmail = doc['email'] as String? ?? '';
                            return _buildUserListItem(User(
                                name: userName, email: userEmail, id: doc.id));
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

  Widget _buildUserListItem(User user) {
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
                user.name,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Container(
            width: 150.w,
            height: 20.h,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                user.email,
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
                _removeUser(user.id);
              },
              child: Text('Remove'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _removeUser(String userId) async {
    try {
      await FirebaseFirestore.instance
          .collection('subadmins')
          .doc(userId)
          .delete();
      print('User removed successfully');
    } catch (error) {
      print('Failed to remove user: $error');
    }
  }
}

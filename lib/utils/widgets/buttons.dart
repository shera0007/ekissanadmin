import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GreenButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressedFunction;

  const GreenButton({
    super.key,
    required this.buttonText,
    required this.onPressedFunction,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 45.h,
      child: MaterialButton(
        onPressed: onPressedFunction,
        height: 45.h,
        color: Color(0xFF34A853),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    );
  }
}

Widget BuildBackButton(BuildContext context) {
  return Positioned(
    top: 20.h,
    left: 10.w,
    child: GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
    BoxShadow(
      color: Color.fromARGB(255, 234, 252, 236), 
      blurRadius: 17, 
      offset: Offset(0, 4), 
    ),
  ],

          
          color: Colors.white,
          border: Border.all(color: Color.fromARGB(255, 219, 219, 219)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final Color borderColor; 
  final TextInputType keyboardType;
  final String headingText; 

  const CustomTextField({
    required this.hintText,
    required this.validator,
    this.controller,
    this.obscureText = false,
     required this.keyboardType,
    this.borderColor = Colors.transparent, 
    required this.headingText, 
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headingText,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 8),
        Container(
          height: 50.h,
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: widget.borderColor), 
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextFormField(
                controller: widget.controller, 
                style: Theme.of(context).textTheme.titleSmall,
                 keyboardType: widget.keyboardType,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  contentPadding: EdgeInsets.symmetric(vertical: 7.h), 
                  errorStyle: TextStyle(fontSize: 11.sp),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white10,
                ),
                validator: widget.validator,
              ),
              if (widget.obscureText)
                IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}

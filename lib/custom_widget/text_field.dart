import 'package:e_learning/constant/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final int? maxLength;
  final bool? must;
  final bool isEmail;
  final bool isMobile;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.maxLength,
    this.must,
    this.isEmail = false,
    this.isMobile = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  bool isValidMobile(String mobile) {
    final mobileRegex = RegExp(r"^[0-9]{10}$");
    return mobileRegex.hasMatch(mobile);
  }

  void validateInput() {
    final text = widget.controller.text.trim();

    if (widget.isEmail) {
      if (text.isEmpty || isValidEmail(text)) {
        setState(() => errorText = null);
      } else {
        setState(() => errorText = 'Invalid email address');
      }
    } else if (widget.isMobile) {
      if (text.isEmpty || isValidMobile(text)) {
        setState(() => errorText = null);
      } else {
        setState(() => errorText = 'Invalid mobile number');
      }
    } else {
      setState(() => errorText = null); // No validation type specified
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            validateInput();
          }
        },
        child: TextField(
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            counterText: "",
            labelText: widget.label,
            suffixIcon: widget.suffixIcon,
            errorText: errorText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.sp),
              borderSide: BorderSide(color: AppColors.themeColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.sp),
              borderSide: BorderSide(color: AppColors.themeColor, width: 1.w),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.sp),
              borderSide: const BorderSide(color: AppColors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.sp),
              borderSide: const BorderSide(color: AppColors.red, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}



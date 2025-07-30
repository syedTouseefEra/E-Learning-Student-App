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
  final Color? borderColor;
  final double? borderRadius;
  final double? fontSize;
  final double? height;
  final int? maxLines; // 🔹 NEW

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
    this.borderColor,
    this.borderRadius,
    this.fontSize,
    this.height,
    this.maxLines, // 🔹 NEW
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  bool isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
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
      setState(() => errorText = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveBorderColor =
        widget.borderColor ?? AppColors.themeColor;
    final double effectiveBorderRadius = widget.borderRadius ?? 30.sp;

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              validateInput();
            }
          },
          child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              maxLines: widget.maxLines ?? 1,
              textAlignVertical: widget.maxLines != null && widget.maxLines! > 1
                  ? TextAlignVertical.top
                  : TextAlignVertical.center,
              decoration: InputDecoration(
                counterText: "",
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: widget.fontSize ?? 14.sp,
                ),
                suffixIcon: widget.suffixIcon,
                errorText: errorText,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: widget.maxLines != null && widget.maxLines! > 1
                      ? 16.h
                      : 12.h,
                  horizontal: 16.w,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  borderSide: BorderSide(color: effectiveBorderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  borderSide:
                      BorderSide(color: effectiveBorderColor, width: 1.w),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  borderSide: const BorderSide(color: AppColors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  borderSide: const BorderSide(color: AppColors.red, width: 1),
                ),
              ))),
    );
  }
}

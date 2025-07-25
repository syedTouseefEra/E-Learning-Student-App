import 'package:e_learning/constant/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? borderWidth;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
    this.padding,
    this.borderWidth,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.themeColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
            side: borderWidth != null
                ? BorderSide(
              color: borderColor ?? AppColors.white,
              width: borderWidth!,
            )
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? AppColors.white,
            fontSize: fontSize ?? 16.sp,
          ),
        ),
      ),
    );
  }
}

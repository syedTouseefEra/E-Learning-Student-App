import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryRow extends StatelessWidget {
  const SummaryRow({
    super.key,
    required this.firstText,
    required this.secondText, this.nullVal
  });

  final String firstText;
  final String secondText;
  final bool? nullVal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: '$firstText -',
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.themeColor,
          fontFamily: 'Inter',
        ),
       nullVal ==true ? CustomText(text: secondText,  fontSize: 16.sp,

         fontWeight: FontWeight.w400,
         color: AppColors.textGrey,
         fontFamily: 'Inter',) : CustomText(
          text: secondText.toString(),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textGrey,
          fontFamily: 'Inter',
        ),
        SizedBox(
          height: 12.sp,
        )

      ],
    );
  }
}



import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/subject_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubjectTile extends StatelessWidget {
  final ColoredSubject coloredSubject;
  final bool isSelected;
  final VoidCallback onTap;

  const SubjectTile({
    super.key,
    required this.coloredSubject,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final subject = coloredSubject.subject;
    final color = coloredSubject.color;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
                border: isSelected? Border.all(color: AppColors.white, width: 2) : null,
              ),

              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Image.asset(
                  subject.imagePath!,
                  width: 50.sp,
                  height: 45.sp,
                  color: AppColors.white,
                ),
              )

            ),
          ),
          SizedBox(height: 8.sp),
          CustomText(text: subject.name,fontSize: 16.sp,fontWeight: FontWeight.w400,fontFamily: 'Inter',maxLines: 1,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}





import 'package:e_learning/components/summary_row.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_container.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummarySection extends ConsumerWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClass = ref.watch(selectedClassProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: CustomContainer(
            padding: 0,
            containerColor: AppColors.lightBlueBackground,
            textAlign: TextAlign.center,
            text: "Summary",
            fontSize: 18.sp,
            fontFamily: 'DM Serif',
            fontColor: AppColors.themeColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            border: Border.all(
              width: 1.sp,
              color: AppColors.themeColor
            )
            ),

          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SummaryRow(
                    firstText: 'Course Name ',
                    secondText: selectedClass?.courseName.toString() ?? "NA"),
                SummaryRow(
                  firstText: 'Batch No ',
                  secondText: selectedClass?.batchName.toString() ?? "NA",
                ),
                SummaryRow(
                  firstText: 'Classes Type ',
                  secondText: selectedClass?.classType.toString() ?? "NA",
                ),
                SummaryRow(
                  firstText: 'Duration ',
                  secondText: formatDuration(
                    selectedClass?.startDate,
                    selectedClass?.endDate,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

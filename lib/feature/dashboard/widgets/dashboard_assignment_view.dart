import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_controller_provider.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class DashboardAssignmentView extends ConsumerWidget {
  const DashboardAssignmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(dashboardControllerProvider);
    final notifier = ref.read(dashboardControllerProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlueBackground, width: 1.5.w),
        borderRadius: BorderRadius.circular(7.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.sp, 8.sp, 15.sp, 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Assignment",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: AppColors.themeColor,
                ),
                CustomSlidingSegmentedControl<int>(
                  initialValue: controller.requestType,
                  height: 25.h,
                  padding: 6.5.w,
                  children: {
                    1: CustomText(
                      text: "  Topic  ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: controller.isTopicView
                          ? AppColors.white
                          : AppColors.themeColor,
                    ),
                    2: CustomText(
                      text: "Module",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: controller.isTopicView
                          ? AppColors.themeColor
                          : AppColors.white,
                    ),
                  },
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.themeColor),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  innerPadding: EdgeInsets.zero,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  onValueChanged: (v) {
                    notifier.changeViewType(v);
                  },
                ),
              ],
            ),
          ),
          Divider(color: AppColors.lightBlueBackground, thickness: 1.sp),
          SizedBox(
            height: 160.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Replace with assignments.length in production
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Container(
                    padding: EdgeInsets.all(6.0.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.lightBlueBackground, width: 0.5.w),
                      borderRadius: BorderRadius.circular(7.h),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Computer Fundamental",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                          color: AppColors.black,
                        ),
                        SizedBox(height: 10.sp),
                        Row(
                          children: [
                            Icon(CupertinoIcons.time,
                                size: 16.sp,
                                color: AppColors.black.withOpacity(0.5)),
                            SizedBox(width: 5.sp),
                            CustomText(
                              text: "10 Jan 2023 - 09:00am 07:00pm",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(CupertinoIcons.square_favorites,
                                size: 15.sp,
                                color: AppColors.black.withOpacity(0.5)),
                            SizedBox(width: 5.sp),
                            CustomText(
                              text: "Multiple choice question",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            Icon(CupertinoIcons.question_circle,
                                size: 15.sp,
                                color: AppColors.black.withOpacity(0.5)),
                            SizedBox(width: 5.sp),
                            CustomText(
                              text: "${10} Question Added",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: MediaQuery.of(context).size.width / 2.5),
                            InkWell(
                              onTap: () {
                                // Action: Start assignment
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlueBackground,
                                  border: Border.all(
                                      color: AppColors.lightBlueBackground,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5.h),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.sp, horizontal: 12.sp),
                                  child: CustomText(
                                    text: "Start Assignment",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: AppColors.themeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5.sp),
        ],
      ),
    );
  }
}

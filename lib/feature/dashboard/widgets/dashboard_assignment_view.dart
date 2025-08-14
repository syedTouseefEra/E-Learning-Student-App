import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_assignment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardAssignmentView extends HookConsumerWidget {
  const DashboardAssignmentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentState = ref.watch(dashboardAssignmentProvider);
    final assignmentNotifier = ref.read(dashboardAssignmentProvider.notifier);

    useEffect(() {
      assignmentNotifier.fetchAssignment();
      return null;
    }, []);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlueBackground, width: 1.5.w),
        borderRadius: BorderRadius.circular(7.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Segmented Control
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
                  initialValue: assignmentNotifier.requestType,
                  height: 25.h,
                  padding: 6.5.w,
                  children: {
                    1: CustomText(
                      text: "  Topic  ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: assignmentNotifier.isWeekView
                          ? AppColors.white
                          : AppColors.themeColor,
                    ),
                    2: CustomText(
                      text: "Module",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: assignmentNotifier.isWeekView
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
                    assignmentNotifier.toggleView(v);
                  },
                ),
              ],
            ),
          ),

          Divider(color: AppColors.lightBlueBackground, thickness: 1.sp),

          // Assignment List
          SizedBox(
            height: 160.h,
            child: assignmentState.when(
              data: (assignments) {
                if (assignments.isEmpty) {
                  return Center(child: Text("No assignments found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final item = assignments[index];
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
                              text: item.courseName ?? '',
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
                                  text: item.startDateTime ?? '',
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
                                  text: item.assignmentType == 1
                                      ? "MCQ"
                                      : 'Subjective',
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
                                  text: "${item.questionCount} Questions Added",
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
                                SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.5),
                                InkWell(
                                  onTap: () {
                                    // TODO: Start assignment logic
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
                );
              },
              loading: () =>
              const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Error: $err')),
            ),
          ),
          SizedBox(height: 5.sp),
        ],
      ),
    );
  }
}

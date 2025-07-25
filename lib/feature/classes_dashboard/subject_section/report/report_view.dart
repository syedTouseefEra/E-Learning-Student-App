import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/report/report_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/report/report_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/report/widget/report_assignment_view.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ReportView extends HookConsumerWidget {
  final String courseName;
  const ReportView({super.key, required this.courseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);
    final selectedClass = ref.watch(selectedClassProvider);
    final instituteId = ref.watch(instituteIdProvider) ?? '';
    final selectedSegment = ref.watch(reportSegmentProvider);
    final searchText = useTextEditingController();
    final isSwapSelected = useState(false);

    final attendanceReportData = ref.watch(attendanceReportProvider(
      AttendanceReportParams(
        startDate: fmt(startDate),
        endDate: fmt(endDate),
        instituteId: instituteId.toString(),
        courseId: selectedClass!.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
      ),
    ));

    final assignmentReportData = ref.watch(assignmentReportProvider(
      AssignmentReportParams(
        instituteId: instituteId.toString(),
        courseId: selectedClass.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
      ),
    ));

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            enableTheming: false,
          ),
          body: Column(
            children: [
              CustomHeaderView(
                courseName: courseName.toString(),
                moduleName: 'Reports',
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            ref.read(reportSegmentProvider.notifier).state =
                                'Attendance';
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedSegment == 'Attendance'
                                  ? AppColors.themeColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.sp, color: AppColors.themeColor),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.sp, vertical: 10.sp),
                              child: CustomText(
                                text: "Attendance",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: selectedSegment == 'Attendance'
                                    ? Colors.white
                                    : AppColors.themeColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15.sp),
                        InkWell(
                          onTap: () {
                            ref.read(reportSegmentProvider.notifier).state =
                                'Assignment';
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedSegment == 'Assignment'
                                  ? AppColors.themeColor
                                  : Colors.white,
                              border: Border.all(
                                  width: 1.sp, color: AppColors.themeColor),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.sp, vertical: 10.sp),
                              child: CustomText(
                                text: "Assignment",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: selectedSegment == 'Assignment'
                                    ? Colors.white
                                    : AppColors.themeColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        isSwapSelected.value =
                            !isSwapSelected.value; // Toggle state
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSwapSelected.value
                              ? AppColors.themeColor
                              : Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: AppColors.themeColor,
                          ),
                          borderRadius: BorderRadius.circular(5.sp),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.sp, vertical: 6.sp),
                          child: Icon(
                            Icons.swap_vert_rounded,
                            size: 26.sp,
                            color: isSwapSelected.value
                                ? Colors.white
                                : AppColors.themeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (isSwapSelected.value) ...[
                if (selectedSegment == 'Attendance') ...[
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DatePickerHelper.datePicker(
                        context,
                        date: startDate,
                        onChanged: (d) =>
                            ref.read(startDateProvider.notifier).state = d,
                      ),
                      DatePickerHelper.datePicker(
                        context,
                        date: endDate,
                        onChanged: (d) =>
                            ref.read(endDateProvider.notifier).state = d,
                      ),
                    ],
                  ),
                ] else if (selectedSegment == 'Assignment') ...[
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DatePickerHelper.datePicker(
                          context,
                          date: startDate,
                          onChanged: (d) =>
                              ref.read(startDateProvider.notifier).state = d,
                        ),
                        SizedBox(width: 16.sp),
                        Expanded(
                          child: SizedBox(
                            height: 35.h,
                            child: CustomTextField(
                              controller: searchText,
                              label: 'Search Notice',
                              suffixIcon: Icon(Icons.search,
                                  color: AppColors.themeColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
              SizedBox(height: 5.h),
              Expanded(
                child: selectedSegment == 'Attendance'
                    ? attendanceReportData.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Error: $e')),
                        data: (list) {
                          final attendanceList = list[0].attandenceReport ?? [];

                          if (attendanceList.isEmpty) {
                            return const Center(child: Text("No data found"));
                          }

                          return ListView.builder(
                            itemCount: attendanceList.length,
                            itemBuilder: (_, i) {
                              final item = attendanceList[i];
                              return Column(
                                children: [
                                  ListTile(
                                    title: CustomText(
                                      text: DateFormat('dd-MM-yyyy').format(
                                        DateTime.parse(
                                            item.calanderDate.toString()),
                                      ),
                                    ),
                                    trailing: CustomText(
                                      text: _attendanceStatus(
                                          item.isPresent ?? 0),
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Inter',
                                      color: _statusColor(item.isPresent ?? 0),
                                    ),
                                  ),
                                  Divider(
                                    height: 0.5.sp,
                                    color: AppColors.lineColor,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                    : assignmentReportData.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Error: $e')),
                        data: (assignmentList) {
                          if (assignmentList.isEmpty) {
                            return const Center(
                                child: Text("No assignment data found"));
                          }
                          return ReportAssignmentView(
                              assignmentList: assignmentList);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _attendanceStatus(int status) {
    switch (status) {
      case 0:
        return 'Absent';
      case 1:
        return 'Present';
      case 2:
        return 'Sunday';
      case 3:
        return 'Holiday';
      case 4:
        return 'Not Mark';
      default:
        return 'Unknown';
    }
  }

  Color _statusColor(int status) {
    switch (status) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
      case 3:
        return AppColors.black;
      case 4:
        return AppColors.yellow;
      default:
        return AppColors.themeColor;
    }
  }
}

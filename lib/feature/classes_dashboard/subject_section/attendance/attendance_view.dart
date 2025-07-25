import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/attendance/attendance_params.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/attendance/attendance_provider.dart';

class AttendanceView extends HookConsumerWidget {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startDate = ref.watch(startDateProvider);
    final endDate = ref.watch(endDateProvider);
    final studentId = ref.read(studentIdProvider);
    final selectedClass = ref.watch(selectedClassProvider);

    useEffect(() {
      if (selectedClass != null) {
        final params = AttendanceParams(
          startDate: fmt(startDate),
          endDate: fmt(endDate),
          studentId: studentId.toString(),
          courseId: selectedClass.courseId.toString(),
          batchId: selectedClass.batchId.toString(),
        );
        ref.invalidate(attendanceProvider(params));
      }
      return null;
    }, [startDate, endDate, selectedClass]);

    final attendanceData = selectedClass == null
        ? const AsyncValue.loading()
        : ref.watch(attendanceProvider(
      AttendanceParams(
        startDate: fmt(startDate),
        endDate: fmt(endDate),
        studentId: studentId.toString(),
        courseId: selectedClass.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
      ),
    ));

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(enableTheming: false),
          body: Column(
            children: [
              CustomHeaderView(
                courseName: selectedClass?.courseName ?? '',
                moduleName: 'Attendance ',
              ),
              SizedBox(height: 10.sp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DatePickerHelper.datePicker(
                    context,
                    date: startDate,
                    onChanged: (d) =>
                    ref.read(startDateProvider.notifier).state = d,
                  ),
                  CustomText(
                    color: AppColors.themeColor,
                    text: "-to-",
                    fontSize: 15.h,
                    fontFamily: 'Dm Serif',
                    fontWeight: FontWeight.w400,
                  ),
                  DatePickerHelper.datePicker(
                    context,
                    date: endDate,
                    onChanged: (d) =>
                    ref.read(endDateProvider.notifier).state = d,
                  ),
                ],
              ),
              SizedBox(height: 15.sp),
              Expanded(
                child: attendanceData.when(
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (list) => list.isEmpty
                      ? const Center(child: Text("No attendance found."))
                      : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) {
                      final item = list[i];
                      return Column(
                        children: [
                          ListTile(
                            title: CustomText(
                              text: DateFormat('dd-MM-yyyy').format(
                                DateTime.parse(
                                    item.attendanceDate.toString()),
                              ),
                            ),
                            trailing: CustomText(
                              text: _attendanceStatus(item.isPresent),
                              fontSize: 16.w,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              color: _statusColor(item.isPresent),
                            ),
                          ),
                          Divider(
                            height: 0.5.sp,
                            color: AppColors.lineColor,
                          ),
                        ],
                      );
                    },
                  ),
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

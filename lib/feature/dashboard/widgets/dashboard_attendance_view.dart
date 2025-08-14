import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/dashboard/data_model/chart_data_model.dart';
import 'package:e_learning/feature/dashboard/data_model/dashboard_attendance_data_model.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_attendance_provider.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardAttendanceView extends HookConsumerWidget {
  final String clgBatchSessionId;

  const DashboardAttendanceView({super.key, required this.clgBatchSessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceState = ref.watch(dashboardAttendanceProvider);
    final controller = ref.read(dashboardAttendanceProvider.notifier);

    useEffect(() {
      controller.fetchAttendance();
      return null;
    }, []);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlueBackground, width: 1.5.w),
        borderRadius: BorderRadius.circular(7.h),
      ),
      child: Column(
        children: [
          SizedBox(height: 10.sp),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Attendance",
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
                      text: "  Week  ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: controller.isWeekView ? AppColors.white : AppColors.themeColor,
                    ),
                    2: CustomText(
                      text: "  Month  ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: controller.isWeekView ? AppColors.themeColor : AppColors.white,
                    ),
                  },
                  innerPadding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.themeColor),
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  thumbDecoration: BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  onValueChanged: (v) {
                    controller.toggleView(v);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 3.sp),
          Divider(color: AppColors.lightBlueBackground, thickness: 1.sp),
          _buildChart(context, attendanceState, controller),
        ],
      ),
    );
  }

  Widget _buildChart(BuildContext context, AsyncValue<List<DashboardAttendanceDataModel>> state, AttendanceController controller) {
    return state.when(
      data: (_) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: AppColors.themeColor, size: 15.sp),
              SizedBox(width: 5.sp),
              CustomText(text: "Present", fontSize: 14.sp, color: AppColors.black),
              SizedBox(width: 15.sp),
              Icon(Icons.circle, color: AppColors.red, size: 15.sp),
              SizedBox(width: 5.sp),
              CustomText(text: "Absent", fontSize: 14.sp, color: AppColors.black),
            ],
          ),
          SfCartesianChart(
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: const CategoryAxis(),
            primaryYAxis: const NumericAxis(
              minimum: 0,
              maximum: 100,
              interval: 20,
            ),
            series: <CartesianSeries>[
              ColumnSeries<ChartData, String>(
                borderRadius: BorderRadius.circular(5.r),
                color: const Color(0xff9F87FF),
                dataSource: controller.presentData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y! > 0 ? data.y : 0.01,
                dataLabelMapper: (ChartData data, _) => '${data.y?.toStringAsFixed(1)}%',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
              ColumnSeries<ChartData, String>(
                borderRadius: BorderRadius.circular(5.r),
                color: const Color(0xffFF5555),
                dataSource: controller.absentData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y! > 0 ? data.y : 0.01,
                dataLabelMapper: (ChartData data, _) => '${data.y?.toStringAsFixed(1)}%',
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          )
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }
}


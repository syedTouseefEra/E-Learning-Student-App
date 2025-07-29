import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/feature/dashboard/dashboard_data_model.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_assignment_view.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_calendar_view.dart';
import 'package:e_learning/feature/dashboard/widgets/dashboard_query_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardView extends HookConsumerWidget {
  final List<DashboardDataModel> data;

  const DashboardView({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(enableTheming: false),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.w),
          child: Column(
            children: [
              const CalendarView(),
              SizedBox(height: 15.h),
              const DashboardAssignmentView(),
              SizedBox(height: 15.h),
              DashboardQueryView()
            ],
          ),
        ),
      ),
    );
  }
}

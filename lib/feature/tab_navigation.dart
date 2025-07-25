
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_provider.dart';
import 'package:e_learning/feature/classes_dashboard/classes_dashboard_view.dart';
import 'package:e_learning/feature/dashboard/dashboard_data_model.dart';
import 'package:e_learning/feature/dashboard/dashboard_view.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/profile_dashboard/profile_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomNavBar extends ConsumerStatefulWidget {
  final List<DashboardDataModel> dashboardData;

  const CustomNavBar({super.key, required this.dashboardData});

  @override
  ConsumerState<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends ConsumerState<CustomNavBar> {
  int _currentIndex = 0;
  List<ClassDashboardDataModel> _classDashboardData = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.dashboardData.isNotEmpty) {
        final token = widget.dashboardData.first.token;
        final studentId = widget.dashboardData.first.userId;
        final instituteId = widget.dashboardData.first.instituteId;
        if (token != null) {
          ref.read(tokenProvider.notifier).state = token;
          ref.read(studentIdProvider.notifier).state = studentId.toString();
          ref.read(instituteIdProvider.notifier).state = instituteId.toString();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardView(data: widget.dashboardData),
      ClassDashboard(data: _classDashboardData),
      const ProfileDashboard(),
    ];

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: pages,
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    List<Map<String, dynamic>> tabs = [
      {'icon': Icons.dashboard, 'text': 'Home'},
      {'icon': Icons.class_, 'text': 'Classes'},
      {'icon': LineIcons.user, 'text': 'Profile'},
    ];

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.sp),
          topRight: Radius.circular(15.sp),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          bool isActive = _currentIndex == index;
          return GestureDetector(
            onTap: () => _onTabChanged(index),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                color: isActive ? AppColors.lightBlue : AppColors.tabbarColor,
                borderRadius: BorderRadius.circular(25.sp),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    tabs[index]['icon'],
                    size: 30.sp,
                    color: AppColors.white,
                  ),
                  if (isActive) ...[
                    SizedBox(width: 5.sp),
                    CustomText(
                      text: tabs[index]['text'],
                      color: AppColors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                    )

                  ],
                ],
              ),
            ),
          );
        }),
      ),
    );
  }




  Future<void> _onTabChanged(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      final token = ref.read(tokenProvider);

      if (token != null) {
        try {
          final data = await ref.read(classDashboardProvider(token).future);
          setState(() {
            _classDashboardData = data;
          });
        } catch (e) {
          debugPrint("Error fetching class dashboard data: $e");
        }
      } else {
        debugPrint("Token not available.");
      }
    }
  }
}









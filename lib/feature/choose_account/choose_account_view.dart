import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/feature/session/session_provider.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/custom_widget/custom_container.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/choose_account/choose_account_data_model.dart';
import 'package:e_learning/feature/dashboard/dashboard_provider.dart';
import 'package:e_learning/feature/tab_navigation.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChooseAccountView extends HookConsumerWidget {
  final List<ChooseAccountDataModel> chooseAccountData;

  const ChooseAccountView({super.key, required this.chooseAccountData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredData =
    chooseAccountData.where((data) => data.roleName == 'Student').toList();

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {

      },
      child: Container(
        color: AppColors.themeColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: filteredData.isEmpty
                ? const Center(child: Text("No students found"))
                : ListView.builder(
              itemCount: filteredData.length,
              padding: EdgeInsets.all(8.sp),
              itemBuilder: (context, index) {
                final data = filteredData[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.sp),
                    border: Border.all(
                      width: 1,
                      color: AppColors.themeColor,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      ref.read(instituteIdProvider.notifier).state =
                          data.instituteId.toString();

                      final params = {
                        'organizationId': data.organizationId,
                        'instituteId': data.instituteId,
                        'userRoleId': data.userRoleId,
                      };

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        final dashboardData = await ref
                            .read(dashboardProvider(params).future);
                        final sessionData = await ref
                            .read(sessionProvider(params).future);
                        Navigator.of(context).pop();
                        NavigationHelper.push(
                          context,
                          CustomNavBar(dashboardData: dashboardData),
                        );
                      } catch (e) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error: ${e.toString()}')),
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          child: CustomContainer(
                            textCase: TextCase.title,
                            padding: 8.sp,
                            innerPadding: EdgeInsets.symmetric(
                                horizontal: 15.sp, vertical: 8.sp),
                            containerColor: AppColors.themeColor,
                            text: data.instituteName?.isEmpty ?? true
                                ? 'NA'
                                : data.instituteName!,
                            fontSize: 15.sp,
                            fontColor: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomContainer(
                              textCase: TextCase.upper,
                              padding: 8.sp,
                              innerPadding: EdgeInsets.symmetric(
                                  horizontal: 15.sp, vertical: 8.sp),
                              containerColor: AppColors.lightBlueBackground,
                              text: getInitials(data.name ?? ''),
                              fontSize: 20.sp,
                              fontColor: AppColors.themeColor,
                              fontWeight: FontWeight.w800,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    textCase: TextCase.title,
                                    text: data.name ?? "User",
                                    fontSize: 16.sp,
                                  ),
                                  CustomText(
                                    textCase: TextCase.title,
                                    text: data.userId?.toString() ?? "N/A",
                                    fontSize: 15.sp,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.sp),
                              child: CustomContainer(
                                innerPadding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 8.sp),
                                borderWidth: 1.sp,
                                borderColor: AppColors.themeColor,
                                containerColor: AppColors.white,
                                text: data.roleName ?? "Role",
                                textAlign: TextAlign.center,
                                fontSize: 15.sp,
                                fontColor: AppColors.themeColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.sp),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 1.sp,
                          color: AppColors.themeColor,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: CustomText(
                            textCase: TextCase.title,
                            text: data.organizationName ?? 'N/A',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

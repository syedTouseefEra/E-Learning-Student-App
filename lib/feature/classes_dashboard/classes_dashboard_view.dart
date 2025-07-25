

import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/subject_section_view.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class ClassDashboard extends HookConsumerWidget {
  final List<ClassDashboardDataModel> data;

  const ClassDashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useTextEditingController();
    final filteredData = useState<List<ClassDashboardDataModel>>(data);

    useEffect(() {
      filteredData.value = data;
      void searchListener() {
        final query = searchText.text.toLowerCase();
        filteredData.value = data.where((item) {
          return item.courseName?.toLowerCase().contains(query) ?? false;
        }).toList();
      }

      searchText.addListener(searchListener);

      return () => searchText.removeListener(searchListener);
    }, [data]);


    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        enableTheming: false,
        notificationCount: 1,
        onNotificationTap: (){
          AlertView().alertToast("coming soon");
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomText(
                      text: 'Classrooms',
                      fontSize: 32.h,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSerif',
                      color: AppColors.yellow,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: searchText,
                      label: 'Search',
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: AppColors.themeColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: data.isEmpty
                          ? ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 50.h,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                          : ListView.builder(
                        itemCount: filteredData.value.length,
                        itemBuilder: (BuildContext context, index) {
                          final item = filteredData.value[index];
                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedClassProvider.notifier).state = item;
                              NavigationHelper.push(
                                context,
                                SubjectSectionView(
                                  courseName: item.courseName.toString(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Container(
                                height: 50.h,
                                width: MediaQuery.sizeOf(context).width,
                                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: AppColors.lightBlueBackground,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: item.courseName.toString(),
                                        fontSize: 15.sp,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                        textCase: TextCase.title,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20.sp,
                                      color: AppColors.tabbarColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_details_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoticeView extends HookConsumerWidget {
  final String courseName;
  const NoticeView({super.key, required this.courseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useTextEditingController();
    final searchQuery = useState('');
    final startDate = ref.watch(startDateProvider);
    final instituteId = ref.read(instituteIdProvider);
    final selectedClass = ref.watch(selectedClassProvider);
    final sessionId = ref.watch(sessionIdProvider);

    final noticeData = ref.watch(noticeProvider(NoticeParams(
      courseId: selectedClass!.courseId.toString(),
      sessionId: sessionId.toString(),
      instituteId: instituteId.toString(),
      batchId: selectedClass.batchId.toString(),
    )));


    useEffect(() {
      void listener() {
        searchQuery.value = searchText.text.toLowerCase();
      }

      searchText.addListener(listener);
      return () => searchText.removeListener(listener);
    }, [searchText]);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(enableTheming: false),
          body: Column(
            children: [
              CustomHeaderView(courseName: courseName, moduleName: 'Class Notice'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                child: Row(
                  children: [
                    DatePickerHelper.datePicker(
                      context,
                      date: startDate,
                      onChanged: (d) => ref.read(startDateProvider.notifier).state = d,
                    ),
                    SizedBox(width: 16.sp),
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                        child: CustomTextField(
                          controller: searchText,
                          label: 'Search Notice',
                          suffixIcon: Icon(Icons.search, color: AppColors.themeColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.sp),
              Container(
                color: AppColors.textGrey.withAlpha(128),
                height: 0.5.h,
                width: double.infinity,
              ),
              SizedBox(height: 10.sp),
              Expanded(
                child: noticeData.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (list) {
                    final filteredList = list.where((item) {
                      final title = item.title?.toLowerCase() ?? '';
                      final description = item.description?.toLowerCase() ?? '';
                      return title.contains(searchQuery.value) || description.contains(searchQuery.value);
                    }).toList();

                    if (filteredList.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Image.asset(ImgAssets.noNotice, width: 300.sp, height: 300.sp),
                            CustomText(
                              fontSize: 20.sp,
                              text: "No “Notice” added yet!",
                              textAlign: TextAlign.center,
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                              textCase: TextCase.title,
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (_, i) {
                        final item = filteredList[i];
                        return Padding(
                          padding: EdgeInsets.all(8.sp),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.themeColor,
                                width: 1.sp,
                              ),
                              borderRadius: BorderRadius.circular(5.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: item.title.toString(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.themeColor,
                                    textCase: TextCase.title,
                                  ),
                                  SizedBox(width: 5.sp),
                                  CustomText(
                                    text: item.createdDate.toString(),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: AppColors.textGrey,
                                  ),
                                  SizedBox(height: 10.sp),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5.sp),
                                        child: Image.network(
                                          '${ApiServiceUrl.urlLauncher}Notice/${item.file!}',
                                          width: 150.sp,
                                          height: 100.sp,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return const Center(child: CircularProgressIndicator());
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return const Icon(Icons.error, color: Colors.red);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.sp),
                                      Expanded(
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            final text = item.description.toString();
                                            const maxLength = 150;
                                            final showReadMore = text.length > maxLength;
                                            final displayText = showReadMore ? truncateText(text, maxLength) : truncateText(text, text.length);
                                            const readMoreText = '...Read More';

                                            return InkWell(
                                              onTap: () {
                                                NavigationHelper.push(
                                                  context,
                                                  NoticeDetailsView(
                                                    courseName: courseName,
                                                    notice: item,
                                                  ),
                                                );
                                              },
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: displayText,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w400,
                                                        color: AppColors.textGrey,
                                                      ),
                                                    ),
                                                    if (showReadMore)
                                                      TextSpan(
                                                        text: readMoreText,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.themeColor,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}

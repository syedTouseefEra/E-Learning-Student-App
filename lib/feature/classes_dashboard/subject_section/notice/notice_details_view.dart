



import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_data_model.dart';
import 'package:e_learning/utils/file_viewer.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NoticeDetailsView extends HookConsumerWidget {
  final String courseName;
  final NoticeDataModel notice;

  const NoticeDetailsView({
    super.key,
    required this.courseName,
    required this.notice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(enableTheming: false),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeaderView(courseName: courseName, moduleName: 'Class Notice'),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: notice.title.toString(),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: AppColors.themeColor,
                        textCase: TextCase.title,
                      ),
                      SizedBox(height: 8.sp),
                      if (notice.file != null)
                        InkWell(
                          onTap: () {
                            final fileUrl = '${ApiServiceUrl.urlLauncher}Notice/${notice.file!}';
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MaterialDetailView(
                                  title: notice.title ?? 'Material',
                                  type: "image",
                                  url: fileUrl,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              '${ApiServiceUrl.urlLauncher}Notice/${notice.file!}',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                              loadingBuilder: (context, child, loadingProgress) =>
                              loadingProgress == null
                                  ? child
                                  : const Center(child: CircularProgressIndicator()),
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      SizedBox(height: 12),
                      CustomText(text: notice.description ?? '',fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColors.textGrey,
                        textCase: TextCase.sentence,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

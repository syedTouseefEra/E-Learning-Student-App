
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/label_value_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTopicListView extends StatelessWidget {
  final List<TopicList> topicListData;
  final void Function(TopicList topic) onTap;
  final bool isAssignment;

  const CustomTopicListView({
    super.key,
    required this.topicListData,
    required this.onTap,
    required this.isAssignment,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: topicListData.length,
      padding: EdgeInsets.all(8.sp),
      itemBuilder: (context, index) {
        final data = topicListData[index];

        return Container(
          margin: EdgeInsets.only(bottom: 12.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(width: 0.5.w, color: AppColors.themeColor),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  maxLines: 2,
                  fontSize: 16.sp,
                  text: data.topicName ?? '',
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w600,
                  textCase: TextCase.title,
                ),
                if ((data.teacherName?.trim().isNotEmpty ?? false)) ...[
                  SizedBox(height: 10.sp),
                  LabelValueText(
                    isRow: true,
                    label: "Teacher Name:",
                    value: data.teacherName ?? '',
                    labelStyle:  TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    valueStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                    valueCase: TextCase.title,
                  ),
                ],
                if ((data.startDate?.trim().isNotEmpty ?? false))
                  LabelValueText(
                    isRow: true,
                    label: "Topic Duration:",
                    value: formatDuration(data.startDate ?? '', data.endDate ?? ''),
                    labelStyle:  TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    valueStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                    valueCase: TextCase.title,
                  ),
                SizedBox(height: 10.sp),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => onTap(data),
                    child: CustomText(
                      text: 'View',
                      fontSize: 14.sp,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

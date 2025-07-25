import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/content_box.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/label_value_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/utils/date_picker_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryTopicListView extends ConsumerStatefulWidget {
  final List<TopicList> topicListData;
  const SummaryTopicListView({super.key, required this.topicListData});

  @override
  ConsumerState<SummaryTopicListView> createState() => _SummaryTopicState();
}

class _SummaryTopicState extends ConsumerState<SummaryTopicListView> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            enableTheming: false,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderView(courseName: "Summary", moduleName: widget.topicListData[0].moduleName.toString(),),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.topicListData.length,
                  padding: EdgeInsets.all(8.sp),
                  itemBuilder: (context, index) {
                    final data = widget.topicListData![index];
                    final isExpanded = expandedIndex == index;

                    return Container(
                      margin: EdgeInsets.only(bottom: 12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.sp),
                        border:
                            Border.all(width: 0.5.sp, color: AppColors.themeColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                    maxLines: 2,
                                    fontSize: 15.sp,
                                    text: data.topicName.toString(),
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w600,
                                    textCase: TextCase.upper,
                                  ),
                                ),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      expandedIndex = isExpanded ? null : index;
                                    });
                                  },
                                  child: Icon(
                                    isExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.sp),
                            CustomText(
                              text: "(${applyTextCase(data.moduleName.toString(), TextCase.title)})",
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                            AnimatedCrossFade(
                              firstChild: Container(),
                              secondChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15.sp),
                                  CustomText(
                                    color: AppColors.textGrey,
                                    maxLines: 3,
                                    text: data.topicDescription.toString(),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    textCase: TextCase.title,
                                  ),
                                  SizedBox(height: 16.sp),
                                  CustomText(
                                    text: 'What’s included',
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                  SizedBox(height: 10.sp),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ContentBox(
                                              icon: Icons.play_circle,
                                              label: '${data.videoCount} Video', height: 45, width: 170,
                                            ),
                                            ContentBox(
                                              icon: Icons.book,
                                              label: '${data.readingCount} Reading', height: 45, width: 170,
                                            ),

                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ContentBox(
                                              icon: Icons.image,
                                              label: '${data.imageCount} Image',height: 45, width: 170,
                                            ),
                                            ContentBox(
                                              icon: Icons.audiotrack,
                                              label: '${data.readingCount} Audio',height: 45, width: 170,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible:
                                        data.teacherName?.trim().isNotEmpty ??
                                            false,
                                    child: LabelValueText(
                                        isRow: true,
                                        label: "Teacher Name:",
                                        value: data.teacherName.toString(),
                                        labelStyle: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.themeColor),
                                        valueStyle: TextStyle(
                                            fontSize: 16.sp, color: AppColors.textGrey),
                                        valueCase: TextCase.title),
                                  ),
                                  SizedBox(height: 5.sp),
                                  Visibility(
                                    visible:
                                        data.startDate?.trim().isNotEmpty ??
                                            false,
                                    child: LabelValueText(
                                        isRow: true,
                                        label: "Topic Duration:",
                                        value: formatDuration(
                                            data.startDate.toString(),
                                            data.endDate.toString()),
                                        labelStyle: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.themeColor),
                                        valueStyle: TextStyle(
                                            fontSize: 16.sp, color: AppColors.textGrey),
                                        valueCase: TextCase.title),
                                  ),
                                ],
                              ),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: Duration(milliseconds: 300),
                            ),
                          ],
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
    );
  }
}


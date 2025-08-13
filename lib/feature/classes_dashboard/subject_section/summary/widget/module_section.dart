import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_container.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/summary/widget/summary_topic_list_view.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleSection extends ConsumerStatefulWidget {
  const ModuleSection({super.key});

  @override
  ConsumerState<ModuleSection> createState() => _ModuleSectionState();
}

class _ModuleSectionState extends ConsumerState<ModuleSection> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final selectedClass = ref.watch(selectedClassProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: CustomContainer(
            padding: 0,
            containerColor: AppColors.lightBlueBackground,
            textAlign: TextAlign.center,
            text: "Modules",
            textColor: AppColors.themeColor,
            fontSize: 18.sp,
            fontFamily: 'DM Serif',
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 12.sp),
        Expanded(
          child: ListView.builder(
            itemCount: selectedClass!.moduleList!.length,
            padding: EdgeInsets.all(8.sp),
            itemBuilder: (context, index) {
              final data = selectedClass.moduleList![index];
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
              child:Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  NavigationHelper.push(
                                      context,
                                      SummaryTopicListView(
                                        topicListData: data.topicList ?? [],
                                      ));
                                },
                                child: CustomText(
                                  maxLines: 2,
                                  text: data.moduleName.toString(),
                                  color: AppColors.themeColor,
                                  fontWeight: FontWeight.w500,
                                  textCase: TextCase.title,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
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
                          text: 'Module ${index + 1}',
                          fontSize: 16.sp,
                          color: AppColors.textGrey,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Inter',
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20.sp),
                              CustomText(
                                  text: 'What you\'ll learn',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: AppColors.themeColor
                              ),
                              SizedBox(height: 5.sp),
                              Row(
                                children: [
                                  Image.asset(
                                    height: 15.sp,
                                    width: 15.sp,
                                    ImgAssets.tick,
                                  ),
                                  SizedBox(width: 15.sp),
                                  CustomText(
                                    text: data.learnDetails.toString(),
                                    fontSize: 16.sp,
                                    color: AppColors.textGrey,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    textCase: TextCase.title,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.sp),
                              CustomText(
                                  text: 'Skill you\'ll gain',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                  color: AppColors.themeColor
                              ),
                              SizedBox(height: 10.sp),
                              Visibility(
                                visible: data.skillGain!.isNotEmpty,
                                child: CustomContainer(
                                  borderRadius: 0,
                                  padding: 0,
                                  text: data.skillGain.toString(),
                                  textColor: AppColors.textGrey,
                                  containerColor: AppColors.lightBlueBackground,
                                  textCase: TextCase.title,
                                ),
                              )
                            ],
                          ),
                          crossFadeState: isExpanded
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
            },
          ),
        ),
      ],
    );
  }
}


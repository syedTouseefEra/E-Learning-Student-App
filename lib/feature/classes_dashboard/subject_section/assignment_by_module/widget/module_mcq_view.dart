import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/mcq_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment_by_module/assignment_by_module_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment_by_module/assignment_by_module_provider.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleMcqView extends ConsumerStatefulWidget {
  final ModuleList module;
  const ModuleMcqView({
    super.key,
    required this.module
  });

  @override
  ConsumerState<ModuleMcqView> createState() => _MCQViewState();
}

class _MCQViewState extends ConsumerState<ModuleMcqView> {
  Map<int, int> selectedAnswers = {};
  int scheduleId = 0;
  int resultId = 0;

  void selectAnswer(int questionId, int optionId) {
    setState(() {
      selectedAnswers[questionId] = optionId;
    });
  }

  bool isSelected(int questionId, int optionId) {
    return selectedAnswers[questionId] == optionId;
  }

  List<Map<String, dynamic>> buildAnswerList() {
    return selectedAnswers.entries.map((entry) {
      return {
        "questionId": entry.key,
        "optionId": entry.value,
        "answer": "null",
        "subjectiveFileAnswer": null,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selectedClass = ref.watch(selectedClassProvider);

    final mcqData = ref.watch(assignmentByModuleMcqDataProvider(
      AssignmentByModuleParams(
        courseId: selectedClass!.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
        moduleId: widget.module.moduleId.toString(),
      ),
    ));

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title:CustomText(
                    text: widget.module.moduleName.toString(),
                    textCase: TextCase.title,
                  ),
            centerTitle: false,
          ),
          body: mcqData.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('No data found')),
            data: (list) {
              final questions =
                  list.isNotEmpty ? list[0].questionList ?? [] : [];
              scheduleId = list[0].scheduleId ?? 0;
              return Column(
                children: [
                  Expanded(
                    child: questions.isEmpty
                        ? const Center(child: Text("No questions found."))
                        : ListView.builder(
                            padding: EdgeInsets.all(15.sp),
                            itemCount: questions.length,
                            itemBuilder: (context, index) {
                              final question = questions[index];
                              final List<OptionList> options =
                                  question.optionList ?? [];
                              final hasImages = options.any(
                                  (o) => (o.imgOption?.isNotEmpty ?? false));
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "Q${index + 1}: ${question.question ?? 'No Question'}",
                                    textCase: TextCase.title,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 10.sp),
                                  hasImages
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: options.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10.sp,
                                            mainAxisSpacing: 10.sp,
                                            childAspectRatio: 1,
                                          ),
                                          itemBuilder: (context, optIndex) {
                                            final option = options[optIndex];
                                            final isOptionSelected = isSelected(
                                                question.scheduleQuestionId ??
                                                    0,
                                                option.assignmentOptionId ?? 0);
                                            return InkWell(
                                              onTap: () {
                                                if (list[0].isAttempt != 1) {
                                                  selectAnswer(
                                                      question.scheduleQuestionId ??
                                                          0,
                                                      option.assignmentOptionId ??
                                                          0);
                                                }
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: option.isTrue != 0
                                                        ? Colors.green
                                                        : isOptionSelected
                                                            ? Colors.green
                                                            : Colors.grey,
                                                    width: 2.sp,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.sp),
                                                ),
                                                padding: EdgeInsets.all(6.sp),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    if (option.imgOption
                                                            ?.isNotEmpty ??
                                                        false)
                                                      Image.network(
                                                        '${ApiServiceUrl.urlLauncher}Assignment/${option.imgOption}',
                                                        height: 140.sp,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    if (option.txtOption
                                                            ?.isNotEmpty ??
                                                        false)
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5.sp),
                                                        child: CustomText(
                                                          text:
                                                              option.txtOption!,
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : Column(
                                          children: options.map((option) {
                                            final isOptionSelected = isSelected(
                                                question.scheduleQuestionId ??
                                                    0,
                                                option.assignmentOptionId ?? 0);

                                            return InkWell(
                                              onTap: () {
                                                if (list[0].isAttempt != 1) {
                                                  selectAnswer(
                                                      question.scheduleQuestionId ??
                                                          0,
                                                      option.assignmentOptionId ??
                                                          0);
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.sp),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      option.isTrue == 1
                                                          ? Icons
                                                              .radio_button_checked
                                                          : isOptionSelected
                                                              ? Icons
                                                                  .radio_button_checked
                                                              : Icons
                                                                  .radio_button_unchecked,
                                                      size: 20.sp,
                                                      color: isOptionSelected
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    ),
                                                    SizedBox(width: 10.sp),
                                                    Expanded(
                                                      child: CustomText(
                                                        text: option.txtOption!,
                                                        textCase:
                                                            TextCase.title,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                  Divider(color: Colors.grey),
                                  SizedBox(height: 20.sp),
                                ],
                              );
                            },
                          ),
                  ),
                  Container(
                    color: AppColors.white,
                    height: 65.sp,
                    child: Column(
                      children: [
                        Divider(height: 1.sp, color: Colors.grey),
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(15.sp, 15.sp, 15.sp, 0.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Total Questions: ${questions.length}",
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Inter',
                                color: Colors.black,
                              ),
                              InkWell(
                                onTap: () async {
                                  final answerList = buildAnswerList();
                                  if (answerList.length !=
                                      list[0].questionList!.length) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "All question are mandatory.")));
                                  } else {
                                    final params = SubmitAssignmentParams(
                                      scheduleId: scheduleId,
                                      questionList: answerList,
                                    );
                                    try {
                                      final result = await ref.read(
                                          submitAssignmentProvider(params)
                                              .future);
                                      debugPrint(
                                          "Submission successful: $result");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Submission successful")),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  height: 35.sp,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5.sp),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomText(
                                    text: "Submit",
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Inter',
                                    color: AppColors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

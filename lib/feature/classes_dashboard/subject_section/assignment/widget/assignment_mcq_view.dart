import 'dart:ffi';
import 'dart:io';

import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/mcq_data_model.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class McqView extends ConsumerStatefulWidget {
  final TopicList topic;
  final bool isAssignment;

  const McqView({
    super.key,
    required this.isAssignment,
    required this.topic,
  });

  @override
  ConsumerState<McqView> createState() => _McqViewState();
}

class _McqViewState extends ConsumerState<McqView> {
  final Map<int, int> selectedAnswers = {};
  int selectedTabIndex = 0;
  int scheduleId = 0;
  late final TextEditingController searchText;

  @override
  void initState() {
    super.initState();
    searchText = TextEditingController();
  }

  @override
  void dispose() {
    searchText.dispose();
    super.dispose();
  }

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

  PlatformFile? pickedFile;
  final ImagePicker _imagePicker = ImagePicker();

  void pickImage() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final XFile? photo =
                      await _imagePicker.pickImage(source: ImageSource.camera);
                  if (photo != null && photo.path.isNotEmpty) {
                    final file = File(photo.path);
                    setState(() {
                      pickedFile = PlatformFile(
                        name: photo.name,
                        path: photo.path,
                        size: file.lengthSync(),
                      );
                    });
                  }
                } catch (e) {
                  print('Camera error: $e');
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.blue),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result != null && result.files.isNotEmpty) {
                    setState(() {
                      pickedFile = result.files.first;
                    });
                  }
                } catch (e) {
                  print('Gallery error: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  final Map<int, bool> showMathFieldMap = {};
  void toggleMathField(int index) {
    if (!showMathFieldMap.containsKey(index)) {
      showMathFieldMap[index] = false;
    }
    showMathFieldMap[index] = showMathFieldMap[index]!;
  }

  @override
  Widget build(BuildContext context) {
    final selectedClass = ref.watch(selectedClassProvider);
    final mcqData = ref.watch(assignmentMcqDataProvider(
      AssignmentParams(
        courseId: selectedClass!.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
        topicId: widget.topic.topicId.toString(),
        moduleId: widget.topic.moduleId.toString(),
        isMcq: selectedTabIndex == 0,
      ),
    ));

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(enableTheming: false),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                CustomHeaderView(
                  courseName: widget.topic.moduleName.toString(),
                  moduleName: widget.topic.topicName.toString(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: Container(
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.themeColor, width: 1.sp),
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: 'MCQ',
                            textColor: selectedTabIndex == 0
                                ? Colors.white
                                : Colors.green,
                            backgroundColor: selectedTabIndex == 0
                                ? Colors.green
                                : Colors.white,
                            borderColor: selectedTabIndex == 0
                                ? Colors.transparent
                                : Colors.green,
                            borderWidth: selectedTabIndex == 0 ? 0 : 1,
                            width: 180.sp,
                            onPressed: () =>
                                setState(() => selectedTabIndex = 0),
                          ),
                          CustomButton(
                            text: 'Subjective',
                            textColor: selectedTabIndex == 0
                                ? Colors.green
                                : Colors.white,
                            backgroundColor: selectedTabIndex == 0
                                ? Colors.white
                                : Colors.green,
                            borderColor: selectedTabIndex == 0
                                ? Colors.green
                                : Colors.transparent,
                            borderWidth: selectedTabIndex == 0 ? 1 : 0,
                            width: 180.sp,
                            onPressed: () =>
                                setState(() => selectedTabIndex = 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: mcqData.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) {
                      debugPrint("❌ API Error: $e");
                      return const Center(child: Text("No data found"));
                    },
                    data: (list) {
                      final questions = list.isNotEmpty
                          ? List<QuestionList>.from(list[0].questionList ?? [])
                          : <QuestionList>[];

                      scheduleId = list[0].scheduleId ?? 0;

                      return Column(
                        children: [
                          Expanded(
                            child: questions.isEmpty
                                ? const Center(
                                    child: Text("No questions found."))
                                : selectedTabIndex == 0
                                    ? _buildMCQList(
                                        questions,
                                        isSelected,
                                        selectAnswer,
                                        list,
                                      )
                                    : _buildSubjectiveList(
                                        questions, searchText),
                          ),
                          _buildSubmitSection(
                            questions.length,
                            context,
                            selectedAnswers,
                            list,
                            scheduleId,
                            ref,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMCQList(
    List<QuestionList> questions,
    bool Function(int, int) isSelected,
    void Function(int, int) selectAnswer,
    List<MCQDataModel> list,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(15.sp),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final options = question.optionList ?? [];
        final hasImages = options.any((o) => o.imgOption?.isNotEmpty ?? false);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    text:
                        "Q${index + 1}: ${question.question ?? 'No Question'}",
                    textCase: TextCase.title,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 5.sp),
                CustomText(
                  text: "Marks ${question.marks}",
                  color: AppColors.yellow,
                )
              ],
            ),
            SizedBox(height: 10.sp),
            hasImages
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.sp,
                      mainAxisSpacing: 3.sp,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, optIndex) {
                      final option = options[optIndex];
                      final isOptionSelected = isSelected(
                        question.scheduleQuestionId ?? 0,
                        option.assignmentOptionId ?? 0,
                      );
                      return InkWell(
                        onTap: () {
                          if (list[0].isAttempt != 1) {
                            selectAnswer(
                              question.scheduleQuestionId ?? 0,
                              option.assignmentOptionId ?? 0,
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              isOptionSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked,
                              color:
                                  isOptionSelected ? Colors.green : Colors.grey,
                              size: 20.sp,
                            ),
                            if (option.txtOption?.isNotEmpty ?? false)
                              CustomText(text: option.txtOption!),
                            if (option.imgOption?.isNotEmpty ?? false)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.sp),
                                child: Image.network(
                                  '${ApiServiceUrl.urlLauncher}Assignment/${option.imgOption}',
                                  height: 140.sp,
                                  width: 150.sp,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                : Column(
                    children: options.map((option) {
                      final isOptionSelected = isSelected(
                        question.scheduleQuestionId ?? 0,
                        option.assignmentOptionId ?? 0,
                      );
                      return InkWell(
                        onTap: () {
                          if (list[0].isAttempt != 1) {
                            selectAnswer(
                              question.scheduleQuestionId ?? 0,
                              option.assignmentOptionId ?? 0,
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.sp),
                          child: Row(
                            children: [
                              Icon(
                                isOptionSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_unchecked,
                                color: isOptionSelected
                                    ? Colors.green
                                    : Colors.grey,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.sp),
                              Expanded(
                                  child: CustomText(text: option.txtOption!)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            Divider(color: Colors.grey),
            SizedBox(height: 10.sp),
          ],
        );
      },
    );
  }

  Widget _buildSubjectiveList(
      List<QuestionList> questions, TextEditingController controller) {
    final file = pickedFile;

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(15.sp),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: "Q${index + 1}: ${question.question}",
                        textCase: TextCase.title,
                        color: AppColors.themeColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 5.sp),
                    CustomText(
                      text: question.marks.toString(),
                      color: AppColors.yellow,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
                SizedBox(height: 8.sp),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.sp)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Answer-",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              // onTap: () => controller.toggleMathField(index),
                              child: CustomText(
                                text: "f(x)",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Obx(() => controller.showMathFieldMap[index]?.value == true
                      //     ? Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: MathField(
                      //     variables: const ['x', 'y', 'z'],
                      //     onChanged: (value) {
                      //       print('Math expression input: $value');
                      //
                      //     },
                      //     decoration: InputDecoration(
                      //       hintText: 'Enter math expression',
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // )
                      //     : SizedBox.shrink()),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                      ),
                      question.studentAnswerType == 2 ||
                              question.studentAnswerType == 3
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  file == null || file.path == null
                                      ? Text('No file chosen')
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: Container(
                                            decoration: BoxDecoration(),
                                            child: Image.file(
                                              File(file.path!),
                                              height: 80.h,
                                              width: 120.w,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  InkWell(
                                    onTap: () => pickImage(),
                                    child: Container(
                                      height: 30.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 5.h),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.textGrey),
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                      child: Text('Upload File'),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text('file should be in Jpg/png format (5mb)'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: question.studentAnswerType == 1 ||
                                question.studentAnswerType == 3
                            ? TextField(
                                minLines: 1,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'hint text',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        BorderSide(color: AppColors.textGrey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        BorderSide(color: AppColors.textGrey),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide:
                                        BorderSide(color: AppColors.textGrey),
                                  ),
                                ),
                              )
                            : question.studentAnswerType == 2
                                ? SizedBox()
                                : CustomText(text: "text"),
                      ),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade300),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitSection(
    int totalQuestions,
    BuildContext context,
    Map<int, int> selectedAnswers,
    List<MCQDataModel> list,
    int scheduleId,
    WidgetRef ref,
  ) {
    return Container(
      color: AppColors.white,
      height: 65.sp,
      child: Column(
        children: [
          Divider(height: 1.sp, color: Colors.grey),
          Padding(
            padding: EdgeInsets.fromLTRB(15.sp, 15.sp, 15.sp, 0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Total Questions: $totalQuestions",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: Colors.black,
                ),
                InkWell(
                  onTap: () async {
                    final answerList = selectedAnswers.entries
                        .map((entry) => {
                              "questionId": entry.key,
                              "optionId": entry.value,
                              "answer": "null",
                              "subjectiveFileAnswer": null,
                            })
                        .toList();

                    if (answerList.length != list[0].questionList!.length) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("All questions are mandatory.")),
                      );
                    } else {
                      try {
                        final result = await ref.read(
                          submitAssignmentProvider(
                            SubmitAssignmentParams(
                              scheduleId: scheduleId,
                              questionList: answerList,
                            ),
                          ).future,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Submission successful")),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: ${e.toString()}")),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 35.sp,
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

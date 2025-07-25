import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/report/report_data_model.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:e_learning/custom_widget/custom_text.dart';

class ReportAssignmentView extends HookConsumerWidget {
  final List<AssignmentReportDataModel> assignmentList;
  const ReportAssignmentView({super.key, required this.assignmentList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<AssignScheduleList> flattenedAssignments = assignmentList
        .expand((student) => student.assignScheduleList ?? [])
        .cast<AssignScheduleList>()
        .toList();

    final totalMarksData = _calculateTotalAverage(flattenedAssignments);

    Map<String, List<AssignScheduleList>> groupedByTopic = {};
    for (var assignment in flattenedAssignments) {
      String topicKey = "${assignment.topicId}_${assignment.topicName}";
      groupedByTopic.putIfAbsent(topicKey, () => []);
      groupedByTopic[topicKey]!.add(assignment);
    }

    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableHeader(totalMarksData),
            _buildTableBody(groupedByTopic),
          ],
        ),
      ),
    );
  }

  /// ✅ Header: topic name + marks summary + headers
  Widget _buildTableHeader(Map<String, dynamic> totalMarksData) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Topic Name
              Container(
                width: 130.w,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  border: Border(right: BorderSide(color: Colors.white, width: 1)),
                ),
                child: CustomText(
                  text: "TOPIC NAME",
                  fontSize: 13.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
              ),
              // MCQ
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.themeColor,
                    border: Border(right: BorderSide(color: Colors.white, width: 1)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: CustomText(
                      text: "MCQ",
                      fontSize: 13.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              // Subjective
              Expanded(
                child: Container(
                  color: AppColors.themeColor,
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: CustomText(
                      text: "SUBJECTIVE",
                      fontSize: 13.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Marks Summary
              Container(
                width: 130.w,
                height: 45.h,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(right: BorderSide(color: Colors.grey.shade300)),
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Marks : ",
                        style: TextStyle(
                          color: AppColors.themeColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "${totalMarksData['userMarks']}/${totalMarksData['totalMarks']} ",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "(${totalMarksData['percentage']}%)",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
                ,
              ),
              // MCQ Header
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(right: BorderSide(color: Colors.white)),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell("MM"),
                      _buildHeaderCell("OM"),
                      _buildHeaderCell("%"),
                    ],
                  ),
                ),
              ),
              // Subjective Header
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(right: BorderSide(color: Colors.white)),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell("MM"),
                      _buildHeaderCell("OM"),
                      _buildHeaderCell("%"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey.shade300)),
        ),
        child: CustomText(
          text: text,
          fontSize: 13.sp,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTableBody(Map<String, List<AssignScheduleList>> groupedByTopic) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: groupedByTopic.entries.map((entry) {
          return _buildTableRow(entry.key, entry.value);
        }).toList(),
      ),
    );
  }


  Widget _buildTableRow(String topicKey, List<AssignScheduleList> assignments) {
    String topicName = assignments.first.topicName.toString();

    AssignScheduleList? mcqAssignment = assignments.firstWhere(
          (a) => a.assignmentType == 2,
      orElse: () => assignments.first,
    );

    AssignScheduleList? subjectiveAssignment = assignments.firstWhere(
          (a) => a.assignmentType == 7,
      orElse: () => assignments.first,
    );

    var mcqData = _getAssignmentData(mcqAssignment, 2);
    var subjectiveData = _getAssignmentData(subjectiveAssignment, 7);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          // Topic Name
          Container(
            width: 130.w,
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: CustomText(
              text: topicName,
              fontSize: 13.sp,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textCase: TextCase.sentence,
            ),
          ),
          // MCQ Section
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: _buildAssignmentCells(mcqData),
            ),
          ),
          // Subjective Section
          Expanded(
            child: _buildAssignmentCells(subjectiveData),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCells(Map<String, dynamic> data) {
    if (data['status'] != null) {
      return Container(
        padding: EdgeInsets.all(8.sp),
        child: Center(
          child: CustomText(
            text: data['status'],
            fontSize: 12.sp,
            color: data['statusColor'],
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Row(
      children: [
        _buildDataCell(data['mm'] ?? "-", Colors.blue),
        _buildDataCell(data['om'] ?? "-", Colors.green),
        _buildDataCell(data['percent'] ?? "-", Colors.red),
      ],
    );
  }

  Widget _buildDataCell(String text, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 13.sp,
            color: color,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> _getAssignmentData(AssignScheduleList assignment, int assignmentType) {
    if (assignment.assignmentType != assignmentType || assignment.assignMarksReportList == null || assignment.assignMarksReportList!.isEmpty) {
      return {
        'status': 'No Assignment Added',
        'statusColor': Colors.grey,
      };
    }

    final report = assignment.assignMarksReportList![0];

    if (report.isAttempt == 0) {
      return {
        'status': 'Not Submitted',
        'statusColor': Colors.orange,
      };
    }

    return {
      'mm': report.totalMarks?.toInt().toString() ?? "-",
      'om': report.userMarks?.toInt().toString() ?? "-",
      'percent': "${report.percentage?.toInt() ?? 0}%",
    };
  }

  /// ✅ Only include attempted assignments
  Map<String, dynamic> _calculateTotalAverage(List<AssignScheduleList> assignments) {
    final Set<String> countedKeys = {};

    double totalUserMarks = 0;
    double totalMaxMarks = 0;

    for (var assignment in assignments) {
      String key = "${assignment.scheduleId}_${assignment.assignmentType}";
      if (countedKeys.contains(key)) continue;

      if (assignment.assignMarksReportList != null && assignment.assignMarksReportList!.isNotEmpty) {
        final report = assignment.assignMarksReportList![0];

        if (report.isAttempt == 1) {
          totalUserMarks += report.userMarks ?? 0;
          totalMaxMarks += report.totalMarks ?? 0;
          countedKeys.add(key);
        }
      }
    }

    double percent = totalMaxMarks > 0 ? (totalUserMarks / totalMaxMarks) * 100 : 0;

    return {
      'userMarks': totalUserMarks.toInt(),
      'totalMarks': totalMaxMarks.toInt(),
      'percentage': percent.toInt()
    };
  }
}


import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Subject {
  final String name;
  final String? imagePath;

  const Subject({required this.name, required this.imagePath});
}

class ColoredSubject {
  final Subject subject;
  final Color color;

  ColoredSubject({required this.subject, required int index})
      : color = _colorList[index % _colorList.length];

  static const List<Color> _colorList = [
    AppColors.summaryIconBgColor,
    AppColors.studyMaterialIconBgColor,
    AppColors.attendanceIconBgColor,
    AppColors.queryIconBgColor,
    AppColors.classNoticeIconBgColor,
    AppColors.discussionIconBgColor,
    AppColors.assignmentIconBgColor,
    AppColors.reportIconBgColor,
  ];
}

final subjectListProvider = Provider.autoDispose<List<ColoredSubject>>((ref) {
  final subjects = [
    Subject(name: 'Summary', imagePath: ImgAssets.summary),
    Subject(name: 'Study Material', imagePath: ImgAssets.studyMaterial),
    Subject(name: 'Attendance', imagePath: ImgAssets.attendance),
    Subject(name: 'Query', imagePath: ImgAssets.query),
    Subject(name: 'Class Notice', imagePath: ImgAssets.notice),
    Subject(name: 'Discussion', imagePath: ImgAssets.chat),
    Subject(name: 'Assignment', imagePath: ImgAssets.assignment),
    Subject(name: 'Reports', imagePath: ImgAssets.reports),
  ];

  return subjects.asMap().entries.map((entry) {
    final index = entry.key;
    final subject = entry.value;
    return ColoredSubject(subject: subject, index: index);
  }).toList();
});

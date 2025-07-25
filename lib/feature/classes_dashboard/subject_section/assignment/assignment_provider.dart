


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/mcq_data_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final assignmentMcqDataProvider = FutureProvider.autoDispose.family<List<MCQDataModel>, AssignmentParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider) ?? '';

    final response = await authService.getMcQ(
      token: token,
      courseId: params.courseId,
      moduleId: params.moduleId,
      topicId: params.topicId,
      batchId: params.batchId, isMcq: params.isMcq,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      print('dataList'+dataList.toString());
      return dataList.map((json) => MCQDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load MCQ data');
    }
  } catch (e) {
    throw Exception('Failed to fetch MCQ data: $e');
  }
});

final submitAssignmentProvider = FutureProvider.autoDispose.family<List<MCQDataModel>, SubmitAssignmentParams>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';

  final response = await authService.submitAssignment(
    token: token,
    scheduleId: params.scheduleId,
    questionList: jsonEncode(params.questionList),
  );

  final body = jsonDecode(response.body);

  if (response.statusCode == 200) {
    final List<dynamic> dataList = body['data'];
    return dataList.map((json) => MCQDataModel.fromJson(json)).toList();
  }

  throw Exception(body['responseMessage'] ?? 'Submission failed');
});






import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/mcq_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment_by_module/assignment_by_module_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final assignmentByModuleMcqDataProvider = FutureProvider.autoDispose.family<List<MCQDataModel>, AssignmentByModuleParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider) ?? '';

    final response = await authService.getMcQByModule(
      token: token,
      courseId: params.courseId,
      moduleId: params.moduleId,
      batchId: params.batchId,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => MCQDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load MCQ data');
    }
  } catch (e) {
    throw Exception('Failed to fetch MCQ data: $e');
  }
});



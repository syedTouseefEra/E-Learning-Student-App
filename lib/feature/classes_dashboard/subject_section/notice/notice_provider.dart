


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_params.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final noticeProvider =
FutureProvider.autoDispose.family<List<NoticeDataModel>, NoticeParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider);
    final response = await authService.getNotice(
      token: token.toString(),
      courseId: params.courseId,
      sessionId: params.sessionId,
      batchId: params.batchId, instituteId: params.instituteId,
    );

    if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => NoticeDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load attendance data');
    }
  } catch (e) {
    print("Error fetching attendance: $e");
    throw Exception('Failed to fetch attendance');
  }
});
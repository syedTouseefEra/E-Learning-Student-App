


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/attendance/attendance_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/attendance/attendance_params.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final attendanceProvider =
FutureProvider.autoDispose.family<List<AttendanceDataModel>, AttendanceParams>((ref, params) async {
  try {
    final token = ref.watch(tokenProvider);
    final response = await ref.read(authServiceProvider).getStudentAttendanceByCourseId(
      startDate: params.startDate,
      endDate: params.endDate,
      courseId: params.courseId,
      studentId: params.studentId,
      batchId: params.batchId, token: token.toString(),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => AttendanceDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load attendance data');
    }
  } catch (e) {
    print("Error fetching attendance: $e");
    throw Exception('Failed to fetch attendance');
  }
});


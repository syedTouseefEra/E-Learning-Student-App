import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/dashboard/data_model/chart_data_model.dart';
import 'package:e_learning/feature/dashboard/data_model/dashboard_attendance_data_model.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardAttendanceProvider = StateNotifierProvider<AttendanceController, AsyncValue<List<DashboardAttendanceDataModel>>>(
      (ref) => AttendanceController(ref),
);

class AttendanceController extends StateNotifier<AsyncValue<List<DashboardAttendanceDataModel>>> {
  final Ref ref;

  AttendanceController(this.ref) : super(const AsyncValue.loading());

  int requestType = 2;
  bool isWeekView = false;

  List<ChartData> presentData = [];
  List<ChartData> absentData = [];

  Future<void> fetchAttendance(String clgBatchSessionId) async {
    try {
      final token = ref.read(userDataProvider).getUserData.token?.toString() ?? '';
      final authService = ref.read(authServiceProvider);

      final response = await authService.getDashboardAttendanceData(
        token: token,
        clgBatchSessionId: clgBatchSessionId,
        requestType: requestType,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List<DashboardAttendanceDataModel> attendanceList = [];

        if (body['data'] is Map<String, dynamic>) {
          final dataMap = body['data'] as Map<String, dynamic>;
          attendanceList = [DashboardAttendanceDataModel.fromJson(dataMap)];
        } else if (body['data'] is List) {
          final dataList = body['data'] as List;
          attendanceList = dataList
              .map((json) => DashboardAttendanceDataModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Unexpected data format');
        }

        // Populate chart data
        presentData = attendanceList
            .map((e) => ChartData(e.subjectName ?? '', (e.presentPercentage ?? 0).toDouble()))
            .toList();

        absentData = attendanceList
            .map((e) => ChartData(e.subjectName ?? '', (e.absentPercentage ?? 0).toDouble()))
            .toList();

        state = AsyncValue.data(attendanceList);
      } else {
        throw Exception('Failed to fetch attendance. Status code: ${response.statusCode}');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void toggleView(int value, String clgBatchSessionId) {
    isWeekView = value == 1;
    requestType = value;
    fetchAttendance(clgBatchSessionId);
  }
}
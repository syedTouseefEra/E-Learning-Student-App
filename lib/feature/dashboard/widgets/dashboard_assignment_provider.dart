



import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/dashboard/data_model/dashboard_attendance_data_model.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashboardAssignmentProvider = StateNotifierProvider<
    AssignmentController,
    AsyncValue<List<DashboardAssignmentDataModel>>>(
      (ref) => AssignmentController(ref),
);

class AssignmentController extends StateNotifier<AsyncValue<List<DashboardAssignmentDataModel>>> {
  final Ref ref;

  AssignmentController(this.ref) : super(const AsyncValue.loading());

  int requestType = 2;
  bool isWeekView = false;

  Future<void> fetchAssignment() async {
    try {
      final token = ref.read(userDataProvider).getUserData.token?.toString() ?? '';
      final authService = ref.read(authServiceProvider);

      final response = await authService.getDashboardAssignmentData(
        token: token,
        type: requestType,
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List<DashboardAssignmentDataModel> assignmentList = [];

        if (body['data'] is Map<String, dynamic>) {
          final dataMap = body['data'] as Map<String, dynamic>;
          assignmentList = [DashboardAssignmentDataModel.fromJson(dataMap)];
        } else if (body['data'] is List) {
          final dataList = body['data'] as List;
          assignmentList = dataList
              .map((json) => DashboardAssignmentDataModel.fromJson(json))
              .toList();
        } else {
          throw Exception('Unexpected data format');
        }

        state = AsyncValue.data(assignmentList);
      } else {
        throw Exception('Failed to fetch attendance. Status code: ${response.statusCode}');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void toggleView(int value,) {
    isWeekView = value == 1;
    requestType = value;
    fetchAssignment();
  }
}
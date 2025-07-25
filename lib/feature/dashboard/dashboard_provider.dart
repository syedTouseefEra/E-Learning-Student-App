


import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/dashboard/dashboard_data_model.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashboardProvider = FutureProvider.family<List<DashboardDataModel>, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final userData = ref.read(userDataProvider);
  final token = userData.getUserData.token?.toString() ?? '';

  final organizationId = params['organizationId'];
  final instituteId = params['instituteId'];
  final userRoleId = params['userRoleId'];

  final response = await authService.getDashboardData(
    token: token,
    organizationId: organizationId,
    instituteId: instituteId,
    userRoleId: userRoleId,
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);

    if (body['data'] is Map<String, dynamic>) {
      final dataMap = body['data'] as Map<String, dynamic>;
      return [DashboardDataModel.fromJson(dataMap)];
    }
    else if (body['data'] is List) {
      final dataList = body['data'] as List;
      return dataList.map((json) => DashboardDataModel.fromJson(json)).toList();
    }
    else {
      throw Exception('Unexpected data format');
    }
  } else {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load dashboard data');
  }
});



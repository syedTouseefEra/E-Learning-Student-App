

import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final classDashboardProvider = FutureProvider.autoDispose.family<List<ClassDashboardDataModel>, String>((ref, token) async {
  final authService = ref.read(authServiceProvider);

  final response = await authService.getStudentModuleAndTopic(token: token);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final List<dynamic> dataList = body['data'];
    return dataList.map((json) => ClassDashboardDataModel.fromJson(json)).toList();
  } else {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load user roles');
  }
});






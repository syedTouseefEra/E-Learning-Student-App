import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/session/session_data_model.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionProvider = FutureProvider.autoDispose.family<List<SessionDataModel>, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final userData = ref.read(userDataProvider);
  final token = userData.getUserData.token?.toString() ?? '';

  final instituteId = params['instituteId'];

  final response = await authService.getStudentSessionDetails(
    token: token,
    instituteId: instituteId,
  );

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);

    if (body['data'] is Map<String, dynamic>) {
      final dataMap = body['data'] as Map<String, dynamic>;
      final session = SessionDataModel.fromJson(dataMap);

      ref.read(sessionIdProvider.notifier).state = session.sessionId.toString();

      return [session];
    }
    else if (body['data'] is List) {
      final dataList = body['data'] as List;
      final sessions = dataList.map((json) => SessionDataModel.fromJson(json)).toList();

      if (sessions.isNotEmpty) {
        ref.read(sessionIdProvider.notifier).state = sessions.first.sessionId.toString();
      }

      return sessions;
    }
    else {
      throw Exception('Unexpected data format');
    }
  } else {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load dashboard data');
  }
});

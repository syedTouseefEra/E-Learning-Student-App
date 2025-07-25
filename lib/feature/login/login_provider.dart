import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = FutureProvider.family<bool, Map<String, String>>((ref, credentials) async {
  final authService = ref.read(authServiceProvider);
  UserData user = UserData();

  final response = await authService.loginUser(
    credentials['mobileNo'] ?? '',
    credentials['password'] ?? '',
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    user.addUserData(Map<String, dynamic>.from(data['data']));
    return true;
  } else {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Login failed');
  }
});

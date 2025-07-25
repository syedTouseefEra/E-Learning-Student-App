
import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final changePasswordProvider = FutureProvider.family<bool, Map<String, String>>((ref, credentials) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider);
  final response = await authService.forgotPassword(
    newPassword: credentials['newPassword'] ?? '', token: token!,
  );

  final data = jsonDecode(response.body);
  final message = data['responseMessage'] ?? '';

  if (response.statusCode == 200 || response.statusCode == 201) {
    return true;
  } else {
    throw Exception(message.isNotEmpty ? message : 'Failed to generate OTP');
  }
});




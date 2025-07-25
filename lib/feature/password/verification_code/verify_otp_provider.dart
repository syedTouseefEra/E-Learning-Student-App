
import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final verifyOtpProvider = FutureProvider.family<bool, Map<String, String>>((ref, credentials) async {
  final authService = ref.read(authServiceProvider);
  final response = await authService.verifyOtp(
    mobileNo: credentials['mobileNo'] ?? '',
    otp: credentials['otp'] ?? '',
  );

  final data = jsonDecode(response.body);
  final message = data['responseMessage'] ?? '';

  if (response.statusCode == 200 || response.statusCode == 201) {
    ref.read(tokenProvider.notifier).state = data['data']['token'];
    return true;
  } else {
    throw Exception(message.isNotEmpty ? message : 'Failed to generate OTP');
  }
});






import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/choose_account/choose_account_data_model.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:convert';

final chooseAccountProvider = FutureProvider.autoDispose<List<ChooseAccountDataModel>>((ref) async {
  final authService = ref.read(authServiceProvider);
  final userData = ref.read(userDataProvider);

  final token = userData.getUserData.token?.toString() ?? '';

  if (token.isEmpty) {
    throw Exception('User token is missing');
  }

  final response = await authService.getUserRole(token: token);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    final List<dynamic> dataList = body['data'];
    return dataList.map((json) => ChooseAccountDataModel.fromJson(json)).toList();
  } else {
    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Failed to load user roles');
  }

});









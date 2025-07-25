

import 'package:e_learning/api_service/api_calling_types.dart';
import 'package:e_learning/api_service/api_service_url.dart';
import 'package:e_learning/auth/auth_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiCallingTypesProvider = Provider<ApiCallingTypes>(
      (ref) => ApiCallingTypes(baseUrl: ApiServiceUrl.apiBaseUrl),
);

final authServiceProvider = Provider<AuthService>(
      (ref) {
    final apiCallingTypes = ref.watch(apiCallingTypesProvider);
    return AuthService(apiCallingTypes: apiCallingTypes);
  },
);

import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/widget/study_material_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/widget/topic_list_data_model.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final studyMaterialProvider = FutureProvider.autoDispose
    .family<List<TopicListDataModel>, StudyMaterialParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider);

    final response = await authService.getAllPublishStudyMaterial(
      token: token.toString(),
      topicId: params.topicId,
    );
    if (response.statusCode == 204) {
      return [];
    } else if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => TopicListDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load study materials');
    }
  } catch (e) {
    print("Error fetching study materials: $e");
    throw Exception('Failed to fetch study materials');
  }
});

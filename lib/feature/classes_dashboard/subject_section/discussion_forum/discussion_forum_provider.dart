


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final discussionForumProvider = FutureProvider.autoDispose.family<List<DiscussionForumDataModel>, DiscussionForumParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider) ?? '';

    final response = await authService.getDiscussionForumData(
      token: token,
      courseId: params.courseId,
      batchId: params.batchId,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => DiscussionForumDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load MCQ data');
    }
  } catch (e) {
    throw Exception('Failed to fetch MCQ data: $e');
  }
});
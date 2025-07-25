


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allThreadCommentProvider = FutureProvider.autoDispose.family<AllThreadCommentDataModel, AllThreadCommentParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider) ?? '';

    final response = await authService.getAllThreadComment(
      token: token,
      threadId: params.threadId,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final jsonData = body['data'][0];
      return AllThreadCommentDataModel.fromJson(jsonData);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load thread data');
    }
  } catch (e) {
    throw Exception('Failed to fetch thread data: $e');
  }
});

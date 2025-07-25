


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createForumProvider = FutureProvider.autoDispose.family<List<CreateForumDataModel>, CreateForumParams>((ref, params) async {
  try {
    final authService = ref.read(authServiceProvider);
    final token = ref.watch(tokenProvider) ?? '';

    final response = await authService.getAllThread(
      token: token,
      forumId: params.forumId,
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> dataList = body['data'];
      return dataList.map((json) => CreateForumDataModel.fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Failed to load MCQ data');
    }
  } catch (e) {
    throw Exception('Failed to fetch MCQ data: $e');
  }
});

final threadLikeProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final threadId = params['threadId'];

  final response = await authService.likeThread(
    token: token,
    threadId: threadId,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});

final threadCommentProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final threadComment = params['threadComment'];
  final threadId = params['threadId'];

  final response = await authService.addThreadComment(
    token: token,
    threadComment: threadComment,
    threadId: threadId,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});


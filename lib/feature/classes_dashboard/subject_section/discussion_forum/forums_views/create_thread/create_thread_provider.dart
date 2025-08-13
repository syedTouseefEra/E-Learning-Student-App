


import 'dart:convert';

import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_forum_params.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createThreadProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final forumId = params['forumId'];
  final title = params['title'];
  final bodyText = params['body'];

  final response = await authService.addThreadPost(
    token: token,
    forumId: forumId,
    title: title,
    body: bodyText,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});


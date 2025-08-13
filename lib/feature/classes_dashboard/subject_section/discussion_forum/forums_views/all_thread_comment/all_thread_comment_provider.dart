


import 'dart:convert';
import 'package:e_learning/auth/auth_service_provider.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_params.dart';
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

final addThreadCommentReplyProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final commentId = params['commentId'];
  final reply = params['reply'];

  final response = await authService.addThreadCommentReply(
    token: token,
    commentId: commentId,
    reply: reply,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});

final allThreadLikeProvider = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final commentId = params['commentId'];

  final response = await authService.likeThreadComment(
    token: token,
    commentId: commentId,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});

final likeThreadCommentReply = FutureProvider.family<String, Map<String, dynamic>>((ref, params) async {
  final authService = ref.read(authServiceProvider);
  final token = ref.watch(tokenProvider) ?? '';
  final replyId = params['replyId'];

  final response = await authService.likeThreadCommentReply(
    token: token,
    replyId: replyId,
  );

  final body = jsonDecode(response.body);

  if ((response.statusCode == 200 || response.statusCode == 201) && body['responseStatus'] == true) {
    return body['responseMessage'] ?? 'Success';
  } else {
    throw Exception(body['message'] ?? 'Failed to like thread');
  }
});
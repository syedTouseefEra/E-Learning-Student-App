
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_forum_provider.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllThreadCommentView extends HookConsumerWidget {
  final String threadId;
  const AllThreadCommentView({super.key, required this.threadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replyText = useTextEditingController();

    final allThreadCommentData = ref.watch(allThreadCommentProvider(
      AllThreadCommentParams(
        threadId: threadId.toString(),
      ),
    ));

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(text: 'New Thread'),
            centerTitle: false,
          ),
          bottomSheet: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical: 5.sp),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45.h,
                      child: CustomTextField(
                        controller: replyText,
                        label: "Reply",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                              try {
                                await ref.read(threadCommentProvider(
                                    {'threadId': threadId,'threadComment':replyText.text.toString()})
                                    .future);

                              } catch (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error: ${e.toString()}")),
                                );
                              }
                            },
                        ),
                      ),
                  ),
                ),
                SizedBox(width: 10.sp,),
                Icon(Icons.cancel)
              ],
            ),
          ),
          body: allThreadCommentData.when(
            data: (data) {
              final comments = data.comments ?? [];

              return ListView.builder(
                padding: EdgeInsets.all(15.sp),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15.sp,
                                backgroundColor: Colors.blue.shade100,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                                  child: CustomText(
                                    text: getInitials(comment.userName!),
                                    fontSize: 8.h,
                                    color: Colors.blue,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.h),
                              CustomText(
                                text: comment.userName ?? '',
                                fontSize: 14.sp,
                                color: Colors.black87,

                              ),
                            ],
                          ),
                          CustomText(
                            text: comment.timeSinceComment ?? '',
                            fontSize: 14.sp,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      CustomText(
                        text: comment.commentTxt ?? '',
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Icon(
                              Icons.thumb_up_alt_outlined,
                              size: 16.sp, color: Colors.blue
                          ),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "Like ${comment.commentLikeCount}",
                              color: AppColors.themeColor
                          ),
                          SizedBox(width: 10.w),
                          Icon(Icons.mode_comment_outlined, size: 16.sp, color: Colors.blue),
                          SizedBox(width: 4.w),
                          CustomText(
                            text: "Reply ${comment.replyCount}",
                            color: AppColors.themeColor,
                          ),
                        ],
                      ),

                      if ((comment.reply?.isNotEmpty ?? false))
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 8.h,bottom: 20.h),
                          child: ListView.builder(
                            itemCount: comment.reply!.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, replyIndex) {
                              final reply = comment.reply![replyIndex];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15.sp,
                                            backgroundColor: Colors.blue.shade100,
                                            child: Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                                              child: CustomText(
                                                text: getInitials(comment.userName!),
                                                fontSize: 8.h,
                                                color: Colors.blue,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.h),
                                          CustomText(
                                            text: comment.userName ?? '',
                                            fontSize: 14.sp,
                                            color: Colors.black87,

                                          ),
                                        ],
                                      ),
                                      CustomText(
                                        text: comment.timeSinceComment ?? '',
                                        fontSize: 14.sp,
                                        color: Colors.black87,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  CustomText(
                                    text: reply.replyTxt ?? '',
                                    fontSize: 14.sp,
                                    color: Colors.black87,
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      Icon(
                                          Icons.thumb_up_alt_outlined,
                                          size: 16.sp, color: Colors.blue
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                          text: "Like ${reply.replyLikeCount}",
                                          color: AppColors.themeColor
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 10.h),
                      Divider(thickness: 1),
                    ],
                  );
                },
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text("Error: $err")),
          ),
        ),
      ),
    );
  }
}

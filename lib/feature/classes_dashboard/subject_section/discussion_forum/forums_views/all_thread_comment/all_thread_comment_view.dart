import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_container.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_provider.dart';

class AllThreadCommentView extends HookConsumerWidget {
  final String threadId;
  const AllThreadCommentView({super.key, required this.threadId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replyText = useTextEditingController();
    final isReplying = useState(false);
    final selectedCommentId = useState<int?>(null);
    final isReplyTextNotEmpty = useState(false);

    final allThreadCommentData = ref.watch(allThreadCommentProvider(
      AllThreadCommentParams(
        threadId: threadId.toString(),
      ),
    ));
    useEffect(() {
      void listener() {
        isReplyTextNotEmpty.value = replyText.text.isNotEmpty;
      }

      replyText.addListener(listener);
      return () => replyText.removeListener(listener);
    }, [replyText]);
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => isReplying.value = false,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(enableTheming: false),
            body: allThreadCommentData.when(
              data: (data) {
                final comments = data.comments ?? [];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeaderView(
                        courseName: data.title ?? " ",
                        moduleName: "Discussion Forum "),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp),
                      child: CustomText(
                        text: data.title.toString(),
                        textCase: TextCase.title,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.themeColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 5.sp),
                      child: CustomText(
                        text: data.body.toString(),
                        fontSize: 14.5.sp,
                        textCase: TextCase.sentence,
                        color: AppColors.textGrey,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 0.5.sp,
                      color: AppColors.textGrey,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(12.sp),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = comments[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15.sp,
                                        backgroundColor:
                                            AppColors.lightBlueBackground,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.sp),
                                          child: CustomText(
                                            text:
                                                getInitials(comment.userName!),
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
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textGrey,
                                      ),
                                    ],
                                  ),
                                  CustomContainer(
                                    padding: 0,
                                    innerPadding: EdgeInsets.symmetric(
                                        horizontal: 14.sp, vertical: 5.sp),
                                    text: "Learner",
                                    containerColor:
                                        AppColors.lightBlueBackground,
                                    textColor: AppColors.themeColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              CustomText(
                                text: comment.commentTxt ?? '',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textGrey,
                                textCase: TextCase.title,
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await ref.read(allThreadLikeProvider({
                                            'commentId': comment.commentId
                                          }).future);
                                          ref.refresh((allThreadCommentProvider(
                                            AllThreadCommentParams(
                                              threadId: threadId.toString(),
                                            ),
                                          )));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.thumb_up_alt_outlined,
                                                size: 16.sp,
                                                color: Colors.blue),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              text:
                                                  "Like ${comment.commentLikeCount}",
                                              color: AppColors.themeColor,
                                            ),
                                            SizedBox(width: 10.w),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          isReplying.value = true;
                                          selectedCommentId.value =
                                              comment.commentId!;
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.mode_comment_outlined,
                                                size: 16.sp,
                                                color: Colors.blue),
                                            SizedBox(width: 4.w),
                                            CustomText(
                                              text:
                                                  "Reply ${comment.replyCount}",
                                              color: AppColors.themeColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      CustomText(
                                        text: comment.timeSinceComment ?? '',
                                        fontSize: 13.sp,
                                        color: AppColors.textGrey,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          AlertView()
                                              .alertToast("Delete tapped");
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.sp, vertical: 3.sp),
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                  Icons.delete_forever_outlined,
                                                  color: AppColors.red,
                                                  size: 18.h),
                                              SizedBox(width: 2.sp),
                                              Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: AppColors.red),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              if ((comment.reply?.isNotEmpty ?? false))
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, top: 0.h, bottom: 2.h),
                                  child: ListView.builder(
                                    itemCount: comment.reply!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, replyIndex) {
                                      final reply = comment.reply![replyIndex];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Divider(),
                                          SizedBox(height: 2.h),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 15.sp,
                                                    backgroundColor: AppColors
                                                        .lightBlueBackground,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 6.sp),
                                                      child: CustomText(
                                                        text: getInitials(
                                                            comment.userName!),
                                                        fontSize: 8.h,
                                                        color: AppColors
                                                            .themeColor,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.h),
                                                  CustomText(
                                                    text:
                                                        comment.userName ?? '',
                                                    fontSize: 14.sp,
                                                    color: AppColors.textGrey,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          CustomText(
                                            text: reply.replyTxt ?? '',
                                            fontSize: 14.sp,
                                            color: AppColors.textGrey,
                                            textCase: TextCase.sentence,
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await ref.read(
                                                      likeThreadCommentReply({
                                                    'replyId': reply.replyId
                                                  }).future);
                                                  ref.refresh(
                                                      (allThreadCommentProvider(
                                                    AllThreadCommentParams(
                                                      threadId:
                                                          threadId.toString(),
                                                    ),
                                                  )));
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                        size: 16.sp,
                                                        color: AppColors
                                                            .themeColor),
                                                    SizedBox(width: 4.w),
                                                    CustomText(
                                                        text:
                                                            "Like ${reply.replyLikeCount}",
                                                        color: AppColors
                                                            .themeColor),
                                                  ],
                                                ),
                                              ),
                                              CustomText(
                                                text:
                                                    comment.timeSinceComment ??
                                                        '',
                                                fontSize: 13.sp,
                                                color: AppColors.textGrey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              Divider(thickness: 1),
                            ],
                          );
                        },
                      ),
                    ),
                    isReplying.value == true
                        ? Container(
                            height: 65.h,
                            color: AppColors.transparent,
                            child: isReplying.value
                                ? Container(
                                    color: AppColors.transparent,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 40.h,
                                              child: CustomTextField(
                                                controller: replyText,
                                                label: "Reply",
                                                suffixIcon: Visibility(
                                                  visible:
                                                      isReplyTextNotEmpty.value,
                                                  child: IconButton(
                                                    icon: Icon(Icons.send),
                                                    onPressed: () async {
                                                      try {
                                                        await ref.read(
                                                          addThreadCommentReplyProvider({
                                                            'commentId':
                                                                selectedCommentId
                                                                    .value,
                                                            'reply': replyText
                                                                .text
                                                                .toString()
                                                          }).future,
                                                        );
                                                        isReplying.value =
                                                            false;
                                                        ref.refresh(
                                                            (allThreadCommentProvider(
                                                          AllThreadCommentParams(
                                                            threadId: threadId
                                                                .toString(),
                                                          ),
                                                        )));

                                                        replyText.clear();
                                                      } catch (e) {
                                                        ScaffoldMessenger.of(
                                                                context)
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
                                          ),
                                          SizedBox(width: 10.sp),
                                          GestureDetector(
                                            onTap: () {
                                              replyText.clear();
                                              isReplying.value = false;
                                            },
                                            child: Icon(Icons.cancel),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : null,
                          )
                        : Container(),
                  ],
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error: $err")),
            ),
          ),
        ),
      ),
    );
  }
}

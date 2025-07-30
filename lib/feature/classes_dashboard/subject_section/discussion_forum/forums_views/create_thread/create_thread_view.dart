import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_thread/create_thread_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_forum_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_forum_provider.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateThreadView extends HookConsumerWidget {
  final int forumId;
  const CreateThreadView({super.key, required this.forumId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = useTextEditingController();
    final bodyText = useTextEditingController();

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                    bottomSheet: Container(
            color: AppColors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      borderColor: AppColors.textGrey,
                      borderWidth: 1.sp,
                      backgroundColor: AppColors.white,
                      height: 38.sp,
                      textColor: AppColors.textGrey,
                      text: "Cancel",
                      onPressed: () {
                        NavigationHelper.pop(context);
                      }),
                  SizedBox(
                    width: 20.sp,
                  ),
                  CustomButton(
                      height: 38.sp,
                      width: 100,
                      text: "Post",
                      onPressed: () async {
                        try {
                          if (title.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.red,
                                content: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: CustomText(
                                    text: "Title is required",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          if (bodyText.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.red,
                                content: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.sp),
                                  child: CustomText(
                                    text: "Body is required",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                            return;
                          }

                          final result = await ref.read(
                            createThreadProvider({
                              'forumId': forumId,
                              'title': title.text.toString(),
                              'body': bodyText.text.toString(),
                            }).future,
                          );

                          if (result.isNotEmpty) {
                            // ✅ Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomText(
                                  text: "Thread added successfully",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Optional delay before popping (to let user read the message)
                            await Future.delayed(Duration(milliseconds: 800));
                            NavigationHelper.pop(context);
                          }

                          // Refresh the forum replies
                          ref.refresh(forumReplyProvider(ForumReplyParams(
                            forumId: forumId.toString(),
                          )));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error: ${e.toString()}")),
                          );
                        }
                      }

                  )
                ],
              ),
            ),
                    ),
                    backgroundColor: AppColors.white,
                    appBar: CustomAppBar(
            enableTheming: false,
            showLogo: false,
            showNotification: false,
                    ),
                    body: Column(
            children: [
              CustomHeaderView(
                  courseName: "Discussion Forum", moduleName: "Crate A New Post"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Material Title",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.sp, left: 3.sp),
                      child: Icon(
                        Icons.star,
                        color: AppColors.red,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: CustomTextField(
                  fontSize: 16.sp,
                  controller: title,
                  label: 'Enter Detail',
                  borderColor: AppColors.black,
                  borderRadius: 10.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 15.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Body",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.sp, left: 3.sp),
                      child: Icon(
                        Icons.star,
                        color: AppColors.red,
                        size: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: CustomTextField(
                  fontSize: 16.sp,
                  controller: bodyText,
                  label: 'Enter Body',
                  borderColor: AppColors.black,
                  borderRadius: 10.sp,
                  maxLines: 5,
                ),
              )
            ],
                    ),
                  ),
          )),
    );
  }
}

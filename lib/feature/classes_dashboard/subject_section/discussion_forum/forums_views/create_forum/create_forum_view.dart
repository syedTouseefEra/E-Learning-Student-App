import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/all_thread_comment/all_thread_comment_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_provider.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateForumView extends HookConsumerWidget {
  final DiscussionForumDataModel forum;
  const CreateForumView({super.key, required this.forum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useTextEditingController();
    final replyText = useTextEditingController();
    final filteredForums = useState<List<dynamic>>([]);
    var threadId = 0;

    final discussionForumData = ref.watch(createForumProvider(
      CreateForumParams(
        forumId: forum.id.toString(),
      ),
    ));

    useEffect(() {
      void listener() {
        final query = searchText.text.toLowerCase();

        final currentData = discussionForumData.asData?.value ?? [];
        filteredForums.value = currentData
            .where((forum) => forum.threadTitle!.toLowerCase().contains(query))
            .toList();
      }

      searchText.addListener(listener);
      return () => searchText.removeListener(listener);
    }, [searchText, discussionForumData]);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(text: forum.title.toString()),
            centerTitle: false,
          ),
          bottomSheet: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
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
                            await ref.read(threadCommentProvider({
                              'threadId': threadId,
                              'threadComment': replyText.text.toString()
                            }).future);

                            ref.refresh(createForumProvider(CreateForumParams(
                              forumId: forum.id.toString(),
                            )));
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.sp,
                ),
                Icon(Icons.cancel)
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                CustomText(
                  text: forum.body.toString(),
                  textCase: TextCase.title,
                  fontSize: 12.h,
                  color: Colors.black54,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          height: 45.h,
                          child: CustomTextField(
                            controller: searchText,
                            label: "Search",
                          )),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    CustomButton(
                        backgroundColor: Colors.green,
                        text: "Create Thread",
                        onPressed: () {},
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 12.sp))
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: discussionForumData.when(
                    data: (forums) {
                      final searchThread = searchText.text.toLowerCase();
                      final getAllThread = searchThread.isEmpty
                          ? forums
                          : forums
                              .where((forum) => forum.threadTitle!
                                  .toLowerCase()
                                  .contains(searchThread))
                              .toList();

                      if (getAllThread.isEmpty) {
                        return const Center(child: Text("No forums found."));
                      }

                      return ListView.builder(
                        itemCount: getAllThread.length,
                        itemBuilder: (context, index) {
                          final thread = getAllThread[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    NavigationHelper.push(
                                        context,
                                        AllThreadCommentView(
                                            threadId: thread.id.toString()));
                                  },
                                  child: CustomText(
                                    text: thread.threadTitle ?? '',
                                    fontSize: 15.sp,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: thread.threadBody ?? '',
                                  fontSize: 14.sp,
                                  color: Colors.black87,
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            try {
                                              await ref.read(threadLikeProvider(
                                                      {'threadId': thread.id})
                                                  .future);

                                              ref.refresh(createForumProvider(
                                                  CreateForumParams(
                                                forumId: forum.id.toString(),
                                              )));
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Error: ${e.toString()}")),
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  size: 16.sp, color: Colors.blue
                                              ),
                                              const SizedBox(width: 4),
                                              CustomText(
                                                  text:
                                                      "Like ${thread.likeCount ?? 0}",
                                                  color: AppColors.themeColor),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        GestureDetector(
                                          onTap: () {
                                            threadId = thread.id!;
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.mode_comment_outlined,
                                                  size: 16, color: Colors.blue),
                                              const SizedBox(width: 4),
                                              CustomText(
                                                  text:
                                                      "Reply ${thread.commentCount ?? 0}",
                                                  color: AppColors.themeColor),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                if (thread.lastRepliedUser != null && thread.lastRepliedUser!.trim().isNotEmpty)
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15.sp,
                                        backgroundColor: Colors.blue.shade100,
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: 6.sp),
                                          child: CustomText(
                                            text: getInitials(thread.lastRepliedUser!),
                                            fontSize: 8.h,
                                            color: Colors.blue,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 6.w),
                                      CustomText(
                                        text:
                                        "${thread.lastRepliedUser} · Replied ${thread.timeSinceLastReply}",
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                    ],
                                  ),

                              ],
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) =>
                        Center(child: CustomText(text: "Error: $e")),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

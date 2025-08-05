import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/forum_reply/forum_reply_forum_view.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiscussionForumView extends HookConsumerWidget {
  const DiscussionForumView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final searchText = useTextEditingController();
    final selectedClass = ref.watch(selectedClassProvider);
    final filteredForums = useState<List<dynamic>>([]);
    final isTapped = useState<int>(0);

    final discussionForumData = ref.watch(discussionForumProvider(
      DiscussionForumParams(
        courseId: selectedClass!.courseId.toString(),
        batchId: selectedClass.batchId.toString(),
      ),
    ));

    useEffect(() {
      void listener() {
        final query = searchText.text.toLowerCase();

        final currentData = discussionForumData.asData?.value ?? [];
        filteredForums.value = currentData
            .where((forum) => forum.title!.toLowerCase().contains(query))
            .toList();
      }
      searchText.addListener(listener);
      return () => searchText.removeListener(listener);
    }, [searchText, discussionForumData]);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            enableTheming: false,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                CustomHeaderView(
                  courseName: selectedClass.courseName ?? '',
                  moduleName: 'Discussion Forum ',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        text: "Add Notice",
                        icon: isTapped.value == 0
                            ? Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 18.h,
                              )
                            : SizedBox(),
                        fontSize: 16.sp,
                        textColor: isTapped.value == 0
                            ? AppColors.white
                            : AppColors.textGrey,
                        backgroundColor: isTapped.value == 0
                            ? AppColors.themeColor
                            : AppColors.lightBlueBackground,
                        onPressed: () {
                          isTapped.value = 0;
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: isTapped.value == 0 ? 10.sp : 12.sp,
                            vertical: 10.sp),
                      ),
                      CustomButton(
                        text: "Post For You",
                        icon: isTapped.value == 1
                            ? Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 18.h,
                              )
                            : SizedBox(),
                        fontSize: 16.sp,
                        textColor: isTapped.value == 1
                            ? AppColors.white
                            : AppColors.textGrey,
                        backgroundColor: isTapped.value == 1
                            ? AppColors.themeColor
                            : AppColors.lightBlueBackground,
                        onPressed: () {
                          isTapped.value = 1;
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: isTapped.value == 1 ? 10.sp : 12.sp,
                            vertical: 10.sp),
                      ),
                      CustomButton(
                        text: "Your Activity",
                        icon: isTapped.value == 2
                            ? Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 18.h,
                              )
                            : SizedBox(),
                        fontSize: 16.sp,
                        textColor: isTapped.value == 2
                            ? AppColors.white
                            : AppColors.textGrey,
                        backgroundColor: isTapped.value == 2
                            ? AppColors.themeColor
                            : AppColors.lightBlueBackground,
                        onPressed: () {
                          isTapped.value = 2;
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: isTapped.value == 2 ? 10.sp : 12.sp,
                            vertical: 10.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  height: 0.5.sp,
                  color: AppColors.textGrey,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                  child: SizedBox(
                      height: 35.h,
                      child: CustomTextField(
                        controller: searchText,
                        label: "Search Student Name/Roll No.",
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.themeColor,
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Container(
                  height: 0.5.sp,
                  color: AppColors.textGrey,
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Expanded(
                  child: discussionForumData.when(
                    data: (forums) {
                      final query = searchText.text.toLowerCase();
                      final forumsToShow = query.isEmpty
                          ? forums
                          : forums
                              .where((forum) =>
                                  forum.title!.toLowerCase().contains(query))
                              .toList();
                      if (forumsToShow.isEmpty) {
                        return const Center(
                            child: CustomText(
                          text: "No Forums Available!",
                        ));
                      }
                      return Padding(
                        padding: EdgeInsets.all(8.h),
                        child: ListView.builder(
                          itemCount: forumsToShow.length,
                          itemBuilder: (context, index) {
                            final forum = forumsToShow[index];
                            return GestureDetector(
                              onTap: () {
                                NavigationHelper.push(
                                  context,
                                  ForumReplyView(forum: forum),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.sp),
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(8.sp),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: forum.title.toString(),
                                      textCase: TextCase.title,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.themeColor,
                                    ),
                                    SizedBox(height: 2.sp),
                                    CustomText(
                                      text: forum.body.toString(),
                                      fontSize: 15.sp,
                                      textCase: TextCase.sentence,
                                      color: AppColors.textGrey,
                                      maxLines: 3,
                                    ),
                                    SizedBox(height: 5.sp),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text:
                                              "Last Post: ${forum.timeSinceLastThread}",
                                          fontSize: 12.sp,
                                          color: AppColors.textGrey,
                                        ),
                                        CustomText(
                                          text: "${forum.threadCount} Threads",
                                          fontSize: 12.sp,
                                          color: AppColors.textGrey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Center(child: Text("Error: $e")),
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

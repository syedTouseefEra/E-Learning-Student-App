import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_params.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/forums_views/create_forum/create_forum_view.dart';
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
          appBar: AppBar(
            title: CustomText(text: 'Discussion Forum'),
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40.h,
                          child: CustomTextField(controller: searchText, label: "Search",)),
                    ),
                    SizedBox(width: 10,),
                    CustomButton(text: "All Forums", onPressed: () {  },padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10))
                  ],
                ),
                const SizedBox(height: 10),
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
                        return const Center(child: CustomText(text: "No Forums Available!",));
                      }

                      return ListView.builder(
                        itemCount: forumsToShow.length,
                        itemBuilder: (context, index) {
                          final forum = forumsToShow[index];
                          return GestureDetector(
                            onTap: (){
                              NavigationHelper.push(context, CreateForumView(forum: forum),);
                              AlertView().alertToast(forum.id.toString());
                            },
                            child: Container(
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
                                  CustomText(
                                    text: forum.title.toString(),
                                    textCase: TextCase.title,
                                    fontSize: 14.h,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.themeColor,
                                  ),
                                  const SizedBox(height: 4),
                                  CustomText(
                                    text: forum.body.toString(),
                                    textCase: TextCase.sentence,
                                    color: Colors.grey[700],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:
                                            "Last Post: ${forum.timeSinceLastThread}",
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      CustomText(
                                        text: "${forum.threadCount} Threads",
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
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

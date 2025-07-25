import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/custom_topic_list_view.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/widget/assignment_mcq_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/widget/topic_details_view.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StudyTopicListView extends HookConsumerWidget {
  final List<TopicList> topicListData;

  const StudyTopicListView({super.key, required this.topicListData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAssignment = ref.watch(isAssignmentProvider);
    final searchText = useTextEditingController();
    final filteredTopics = useState<List<TopicList>>(topicListData);

    void filterTopics(String query) {
      if (query.isEmpty) {
        filteredTopics.value = topicListData;
      } else {
        filteredTopics.value = topicListData.where((topic) {
          final name = topic.topicName?.toLowerCase() ?? '';
          final teacher = topic.teacherName?.toLowerCase() ?? '';
          final search = query.toLowerCase();
          return name.contains(search) || teacher.contains(search);
        }).toList();
      }
    }

    useEffect(() {
      searchText.addListener(() {
        filterTopics(searchText.text);
      });
      return null;
    }, const []);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(enableTheming: false),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                CustomHeaderView(
                  courseName: "Study Material",
                  moduleName: topicListData[0].moduleName ?? "",
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(12.sp, 5.sp, 10.sp, 10.sp),
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Topic',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DMSerif',
                        color: AppColors.themeColor,
                      ),
                      SizedBox(width: 20.sp),
                      Expanded(
                        child: SizedBox(
                          height: 40.h,
                          child: CustomTextField(
                            controller: searchText,
                            label: 'Search',
                            suffixIcon: Icon(Icons.search, color: AppColors.themeColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredTopics.value.isEmpty
                      ? Center(
                    child: CustomText(
                      text: searchText.text.isEmpty
                          ? 'Start typing to search topics'
                          : 'No topics found',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  )
                      : CustomTopicListView(
                    topicListData: filteredTopics.value,
                    isAssignment: isAssignment ?? false,
                    onTap: (topic) {
                      if (isAssignment == true) {
                        NavigationHelper.push(
                          context,
                          McqView(isAssignment: isAssignment!, topic: topic),
                        );
                      } else {
                        NavigationHelper.push(
                          context,
                          TopicDetailView(topicId: topic.topicId.toString(), topicName: topic.topicName.toString(),),
                        );
                      }
                    },
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


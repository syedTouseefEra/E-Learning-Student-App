import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment/assignment_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment_by_module/assignment_by_module_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/attendance/attendance_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/discussion_forum/discussion_forum_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/notice/notice_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/query/query_teacher_list_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/report/report_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/study_material_view.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/custom_widget/subject_tile.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/subject_provider.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/summary/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubjectSectionView extends HookConsumerWidget {
  final String courseName;
  const SubjectSectionView({
    super.key,
    required this.courseName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coloredSubjectList = ref.watch(subjectListProvider);
    final selectedIndex = useState<int?>(null);

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: CustomAppBar(
              enableTheming: false,
            ),

            body: Column(
              children: [
                CustomHeaderView(courseName: courseName.toString(), moduleName: '',),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: coloredSubjectList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12.sp,
                        crossAxisSpacing: 15.sp,
                        childAspectRatio: 1.sp,
                      ),
                      itemBuilder: (context, index) {
                        final coloredSubject = coloredSubjectList[index];
                        final isSelected = selectedIndex.value == index;

                        return SubjectTile(
                          coloredSubject: coloredSubject,
                          isSelected: isSelected,
                          onTap: () {
                            selectedIndex.value = index;
                            switch (selectedIndex.value) {
                              case 0:
                                NavigationHelper.push(
                                    context, SummaryView(courseName: courseName.toString()));
                                break;
                              case 1:
                                ref.read(isAssignmentProvider.notifier).state =
                                    false;
                                NavigationHelper.push(
                                    context, const StudyMaterialView());
                                break;
                              case 2:
                                NavigationHelper.push(
                                    context, AttendanceView());
                                break;
                              case 3:
                                NavigationHelper.push(
                                    context, const QueryTeacherListView());
                                break;
                              case 4:
                                NavigationHelper.push(
                                    context, NoticeView(courseName: courseName.toString()));
                                break;
                              case 5:
                                NavigationHelper.push(
                                    context, const DiscussionForumView());
                                break;
                              case 6:
                                ref.read(isAssignmentProvider.notifier).state =
                                    true;
                                NavigationHelper.push(
                                    context, AssignmentView(courseName: courseName.toString()));
                                break;
                              case 7:
                                ref.read(isAssignmentProvider.notifier).state =
                                    true;
                                NavigationHelper.push(
                                    context, ReportView(courseName: courseName.toString()));
                                break;
                              case 8:
                                NavigationHelper.push(
                                    context, ModuleAssignmentView(courseName: courseName.toString()));
                                break;
                              default:
                                break;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

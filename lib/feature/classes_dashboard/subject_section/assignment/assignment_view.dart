import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/custom_widget/custom_module_list_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/study_material/widget/study_topic_list.dart';

class AssignmentView extends HookConsumerWidget {
  final String courseName;
  const AssignmentView({super.key,required this.courseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = useTextEditingController();
    final selectedClass = ref.watch(selectedClassProvider);

    final filteredModules = useState<List<ModuleList>>(selectedClass!.moduleList!);

    useEffect(() {
      void onSearchChanged() {
        final query = searchText.text.trim().toLowerCase();
        if (query.isEmpty) {
          filteredModules.value = selectedClass.moduleList!;
        } else {
          filteredModules.value = selectedClass.moduleList!.where((module) {
            final name = module.moduleName?.toLowerCase() ?? '';
            return name.contains(query);
          }).toList();
        }
      }

      searchText.addListener(onSearchChanged);


      return () => searchText.removeListener(onSearchChanged);
    }, [searchText]);

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
              CustomHeaderView(
                courseName: courseName.toString(),
                moduleName: 'Assignment',
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.sp, 5.sp, 10.sp, 10.sp),
                child: Row(
                  children: [
                    CustomText(
                      text: 'Modules',
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
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search, color: AppColors.themeColor),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CustomModuleListView(
                  modules: filteredModules.value,
                  onTap: (module) {
                    NavigationHelper.push(
                      context,
                      StudyTopicListView(topicListData: module.topicList ?? []),
                    );
                  },
                ),
              ),
            ],
          )
          ,
        ),
      ),
    );
  }
}

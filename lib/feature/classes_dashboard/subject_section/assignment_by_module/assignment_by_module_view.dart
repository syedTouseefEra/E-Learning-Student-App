import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_module_list_view.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/assignment_by_module/widget/module_mcq_view.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModuleAssignmentView extends HookConsumerWidget {
  final String courseName;
  const ModuleAssignmentView({super.key, required this.courseName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClass = ref.watch(selectedClassProvider);
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(
            enableTheming: false,
          ),
          body: CustomModuleListView(
            modules: selectedClass!.moduleList!,
            onTap: (module) {
              NavigationHelper.push(
                context,
                ModuleMcqView(module: module),
              );
            },
          ),
        ),
      ),
    );
  }
}

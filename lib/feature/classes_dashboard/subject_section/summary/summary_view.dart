
import 'package:e_learning/components/custom_appbar.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_header_view.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/summary/widget/module_section.dart';
import 'package:e_learning/feature/classes_dashboard/subject_section/summary/widget/summary_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class SummaryView extends StatefulHookConsumerWidget {
  final String courseName;
  const SummaryView({super.key,required this.courseName});

  @override
  ConsumerState<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends ConsumerState<SummaryView> {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            enableTheming: false,
            showLogo: false,
          ),
          body: Column(
            children: [
              CustomHeaderView(courseName: widget.courseName.toString(), moduleName: 'Summary',),
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.fromLTRB(15.sp, 5.sp, 15.sp, 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SummarySection(),
                      SizedBox(height: 10.sp),
                      Expanded(child: ModuleSection())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


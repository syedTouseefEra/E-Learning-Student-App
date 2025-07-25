
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/classes_dashboard/class_dashboard_data_model.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomModuleListView extends StatelessWidget {
  final List<ModuleList> modules;
  final void Function(ModuleList module) onTap;

  const CustomModuleListView({
    super.key,
    required this.modules,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return modules.isEmpty?SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImgAssets.noMaterial,width: 300,height: 300,),
          CustomText(
            fontSize: 20.sp,
            text: "No “Study Material” \n added yet",
            textAlign: TextAlign.center,
            color: AppColors.themeColor,
            fontWeight: FontWeight.w600,
            textCase: TextCase.title,
          ),
        ],
      ),
    ):ListView.builder(
      itemCount: modules.length,
      padding: EdgeInsets.all(8.sp),
      itemBuilder: (context, index) {
        final data = modules[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.sp),
          height: 120.sp,
          decoration: BoxDecoration(
            color: AppColors.lightBlueBackground,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  maxLines: 2,
                  fontSize: 16.sp,
                  text: data.moduleName ?? '',
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w400,
                  textCase: TextCase.title,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => onTap(data),
                    child: CustomText(
                      text: 'View',
                      fontSize: 14.sp,
                      color: AppColors.textGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

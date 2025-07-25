import 'package:e_learning/auth/get_providers.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QueryTeacherListView extends HookConsumerWidget {
  const QueryTeacherListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClass = ref.watch(selectedClassProvider);
    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(text: 'Teacher List'), centerTitle: false,),
          body: ListView.builder(
            itemCount: selectedClass!.moduleList![0].topicList!.length,
            itemBuilder: (BuildContext context, int index) {
             var data = selectedClass.moduleList![0].topicList![index];
              return Visibility(
                visible: data.teacherName != "  " ,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(8.sp)),
                      child: Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //   radius: 20.h,
                            //   backgroundImage: (data.profileImage == null ||
                            //       data.profileImage == "")
                            //       ? const AssetImage(ImgAssets.user)
                            //       : NetworkImage(
                            //       '${ApiServiceUrl.urlLauncher}ProfileImage/${teacher.profileImage}')
                            //   as ImageProvider,
                            // ),
                            Container(
                              height: 55.sp,
                              width: 55.sp,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.themeColor,
                                    width: 1.sp,
                                  ),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              child: Icon(
                                Icons.person,
                                size: 45.sp,
                              ),
                            ),
                            CustomText(text: data.teacherName.toString()),
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

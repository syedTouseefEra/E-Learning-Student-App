import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardQueryView extends StatelessWidget {
  const DashboardQueryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlueBackground, width: 1.5.w),
        borderRadius: BorderRadius.circular(7.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.sp, 15.sp, 15.sp, 8.sp),
            child: CustomText(
              text: "Query",
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              color: AppColors.themeColor,
            ),
          ),
          Divider(color: AppColors.lightBlueBackground, thickness: 1.sp),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 5.sp),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                // var queryData = controller.getDashboardQueryData[index];
                return Padding(
                  padding:  EdgeInsets.all(8.sp),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.toNamed(NamedRoutes.queryChat, arguments: [
                          //   queryData.replyList,
                          //   queryData.query,
                          //   queryData.profileImage,
                          //   queryData.query!.capitalize,
                          //   queryData.id,
                          //   queryData.batchSubjectId,
                          //   true,
                          //   queryData.teacherName,
                          //   true
                          //
                          // ]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            // color: queryData.isView == 0
                            //     ? AppColors.lightBlueBackground
                            //     : AppColors.white,
                            color: index ==0 || index == 1 ||index == 2 ? AppColors.lightBlueBackground : AppColors.white,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(10.sp),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.h,
                                  backgroundImage:
                                      const AssetImage(ImgAssets.user),
                                  // backgroundImage:
                                  //     queryData.profileImage?.isEmpty ?? true
                                  //         ? const AssetImage(ImgAssets.user)
                                  //             as ImageProvider
                                  //         : NetworkImage(
                                  //             '${ApiServiceUrl.urlLauncher}ProfileImage/${queryData.profileImage}',
                                  //           ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        // text: queryData.teacherName!.capitalize
                                        //     .toString(),
                                        text: "Syed Touseef",
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black,
                                      ),
                                      CustomText(
                                        // text: queryData.query.toString(),
                                        text: "Testing eLearning",
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            AppColors.darkGrey.withOpacity(0.7),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: index ==0 || index == 1 ||index == 2,
                        child: Positioned(
                          top: -10.sp,
                          right: 20,
                          child: Image.asset(
                            ImgAssets.notificationYellow,
                            height: 22.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 5.sp),
        ],
      ),
    );
  }
}

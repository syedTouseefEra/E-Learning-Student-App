import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final double height;
//   final int notificationCount;
//   final VoidCallback? onNotificationTap;
//   final bool enableTheming;
//
//   const CustomAppBar({
//     super.key,
//     this.height = 50,
//     this.notificationCount = 0,
//     this.onNotificationTap,
//     this.enableTheming = true,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDarkMode = theme.brightness == Brightness.dark;
//
//     final Color backgroundColor = enableTheming
//         ? (isDarkMode ? Colors.grey[900]! : AppColors.white)
//         : AppColors.themeColor;
//
//     final Color badgeTextColor =
//         enableTheming ? AppColors.white : AppColors.white;
//
//     final Color badgeBackgroundColor =
//         enableTheming ? Colors.deepOrange : AppColors.yellow;
//
//     return Container(
//       height: height.h,
//       decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(15.sp),
//               bottomRight: Radius.circular(15.sp))),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               ImgAssets.eduLogo,
//             ),
//             GestureDetector(
//               onTap: onNotificationTap,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Image.asset(
//                     ImgAssets.notification,
//                   ),
//                   if (notificationCount > 0)
//                     Positioned(
//                       bottom: -2.sp,
//                       right: -5.sp,
//                       child: Container(
//                         padding: EdgeInsets.all(2.sp),
//                         constraints: BoxConstraints(
//                           minWidth: 20.sp,
//                           minHeight: 20.sp,
//                         ),
//                         decoration: BoxDecoration(
//                           color: badgeBackgroundColor,
//                           borderRadius: BorderRadius.circular(20.sp),
//                         ),
//                         child: Center(
//                           child: CustomText(
//                             text: notificationCount.toString(),
//                             fontSize: 12.sp,
//                             color: badgeTextColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(height.h);
// }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final int notificationCount;
  final VoidCallback? onLogoTap;
  final VoidCallback? onNotificationTap;
  final bool enableTheming;

  // New optional flags
  final bool showLogo;
  final bool showNotification;

  const CustomAppBar({
    super.key,
    this.height = 50,
    this.notificationCount = 0,
    this.onLogoTap,
    this.onNotificationTap,
    this.enableTheming = true,
    this.showLogo = true,
    this.showNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final Color backgroundColor = enableTheming
        ? (isDarkMode ? Colors.grey[900]! : AppColors.white)
        : AppColors.themeColor;

    final Color badgeTextColor =
    enableTheming ? AppColors.white : AppColors.white;

    final Color badgeBackgroundColor =
    enableTheming ? Colors.deepOrange : AppColors.yellow;

    return Container(
      height: height.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.sp),
          bottomRight: Radius.circular(15.sp),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 8.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (showLogo)
              InkWell(
                splashColor: AppColors.transparent,
                onTap: (){
                  onLogoTap?.call();
                },
                child: Image.asset(
                  ImgAssets.eduLogo,
                ),
              )
            else
              const SizedBox(), // empty widget to keep spacing

            if (showNotification)
              InkWell(
                splashColor: AppColors.transparent,
                onTap: (){
                  onNotificationTap?.call();
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      ImgAssets.notification,
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        bottom: -2.sp,
                        right: -5.sp,
                        child: Container(
                          padding: EdgeInsets.all(2.sp),
                          constraints: BoxConstraints(
                            minWidth: 20.sp,
                            minHeight: 20.sp,
                          ),
                          decoration: BoxDecoration(
                            color: badgeBackgroundColor,
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: Center(
                            child: CustomText(
                              text: notificationCount.toString(),
                              fontSize: 12.sp,
                              color: badgeTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height.h);
}

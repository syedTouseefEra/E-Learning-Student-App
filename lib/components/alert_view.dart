


import 'package:fluttertoast/fluttertoast.dart';

class AlertView {
  void alertToast(String message) {
    Fluttertoast.showToast(
      msg: message,
    );
  }


  // doubleButton(context,String? title, String massage,  Function yesPressEvent) {
  //   Get.dialog(
  //     barrierDismissible: true,
  //     Material(
  //       color: Colors.transparent,
  //       child: Center(
  //         child: Padding(
  //           padding: const EdgeInsets.all(25.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15.sp),
  //               color: AppColors.white,
  //             ),
  //             // height: height ?? 140,
  //             width: Get.width,
  //             child: Padding(
  //                 padding: EdgeInsets.all(8.sp),
  //                 child: Stack(
  //                   alignment: const AlignmentDirectional(0, -1.65),
  //                   children: [
  //                     Image.asset(
  //                       ImgAssets.cancelIcon,
  //                       height: 50.h,
  //                     ),
  //                     Column(
  //                       mainAxisSize: MainAxisSize.min,
  //                       children: [
  //                         SizedBox(height: 10.sp),
  //                         Text(title ?? "Alert!",
  //                             style: MyTextTheme.mediumPCB),
  //                         Padding(
  //                           padding: EdgeInsets.all(8.sp),
  //                           child: CustomText(
  //                             textAlign: TextAlign.center,
  //                             text: massage.capitalize!,
  //                             fontSize: 16.sp,
  //                             fontWeight: FontWeight.w500,
  //                             fontFamily: 'Roboto',
  //                             texting: true,
  //                             textColor: AppColors.darkGrey,
  //                           ),
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             InkWell(
  //                               onTap: () {
  //                                 Get.back();
  //                               },
  //                               child: Container(
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 30.sp, vertical: 5.sp),
  //                                 decoration: BoxDecoration(
  //                                   border: Border.all(
  //                                       width: 1.sp,
  //                                       color: AppColors.darkGrey.withOpacity(0.7.sp)
  //                                   ),
  //                                   borderRadius: BorderRadius.circular(5.sp),
  //                                 ),
  //                                 child: CustomText(
  //                                   text: "Cancel",
  //                                   fontSize: 16.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   fontFamily: 'Roboto',
  //                                   texting: true,
  //                                   textColor: AppColors.darkGrey.withOpacity(0.7.sp),
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(width: 70.sp),
  //                             InkWell(
  //                               onTap: () {
  //                                 Get.back();
  //                                 yesPressEvent();
  //                               },
  //                               child: Container(
  //                                 padding: EdgeInsets.symmetric(
  //                                     horizontal: 45.sp, vertical: 7.sp),
  //                                 decoration: BoxDecoration(
  //                                     color: Colors.green,
  //                                     borderRadius: BorderRadius.circular(5.sp)),
  //                                 child: CustomText(
  //                                   text: "Yes",
  //                                   fontSize: 16.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   fontFamily: 'Roboto',
  //                                   texting: true,
  //                                   textColor: AppColors.white,
  //                                 ),
  //                               ),
  //                             ),
  //                             SizedBox(height: 70.sp),
  //                           ],
  //                         ),
  //                       ],
  //                     )
  //                   ],
  //                 )),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
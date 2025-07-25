
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_learning/components/alert_view.dart';
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/constant/strings.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImgAssets.noInternet,
              height: 233.h,
              width: 400.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomText(
              text: strNoInternet,
              fontSize: 25.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.themeColor,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              text: strSorryNoInternet,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xff888888),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
              onTap: () async {
                AlertView().alertToast("Please connect to the internet");
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                width: 297.w,
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(28.h),
                ),
                child: CustomText(
                  text: strTryAgain,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

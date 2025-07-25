import 'package:e_learning/components/check_internet_connectivity.dart';
import 'package:e_learning/components/my_swipe_button.dart';
import 'package:e_learning/components/no_internet_view.dart';
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/constant/strings.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/choose_account/choose_account_provider.dart';
import 'package:e_learning/feature/choose_account/choose_account_view.dart';
import 'package:e_learning/feature/login/login_view.dart';
import 'package:e_learning/user_data/user_data.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusScope.of(context).unfocus();
    final animationController = useAnimationController(
      duration: const Duration(seconds: 5),
    )..repeat();

    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                ImgAssets.hat,
                height: 96.h,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                RotationTransition(
                  turns: animationController,
                  child: Image.asset(ImgAssets.blueCircle, height: 200.w),
                ),
                Image.asset(
                  ImgAssets.whiteCircle,
                  height: 210.w,
                ),
                Image.asset(
                  ImgAssets.colorLogo,
                  height: 115.w,
                ),
              ],
            ),
            SizedBox(height: 20.w),
            CustomText(
              text: strHead,
              fontSize: 30.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSerif',
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.w),
            CustomText(
              text: strBottom,
              fontSize: 16.w,
              fontWeight: FontWeight.w300,
              fontFamily: 'Inter',
              color: AppColors.white,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 27.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.white,
                    AppColors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(35.w),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0.w),
                child: MySwipeButton(
                  width: 190.w,
                  onSubmit: () async {
                    FocusScope.of(context).unfocus();
                    final connectivity = ref.read(connectionStatusProvider);

                    if (!connectivity) {
                      NavigationHelper.push(context, const NoInternetView());
                      return;
                    }

                    if (UserData().getUserData.token == null) {
                      NavigationHelper.push(context, const LoginView());
                    } else {
                      final chooseAccountData = await ref.read(chooseAccountProvider.future);
                      NavigationHelper.push(context, ChooseAccountView(chooseAccountData: chooseAccountData));
                    }
                  },

                  backgroundColor: AppColors.transparent,
                  title: strGetStart,
                  textStyle: TextStyle(
                    color: AppColors.themeColor,
                    fontFamily: 'Inter',
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                  ),
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

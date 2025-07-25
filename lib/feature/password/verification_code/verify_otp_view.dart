import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/feature/password/change_password/change_password_view.dart';
import 'package:e_learning/feature/password/reset_password/reset_password_provider.dart';
import 'package:e_learning/feature/password/verification_code/verify_otp_provider.dart';
import 'package:e_learning/utils/custom_function_utils.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyOtpView extends HookConsumerWidget {
  final String mobileEmailValue;
  const VerifyOtpView({super.key, required this.mobileEmailValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeControllers = List.generate(6, (_) => useTextEditingController());
    final focusNodes = List.generate(6, (_) => useFocusNode());
    final isFormFilled = useState(false);
    final isLoading = useState(false);

    void handleInputChange(int index, String value) {
      if (value.isNotEmpty && index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else if (value.isEmpty && index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }

    return Container(
      color: AppColors.themeColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
            centerTitle: false,
            backgroundColor: AppColors.themeColor,
          ),
          backgroundColor: AppColors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Image.asset(ImgAssets.blueBg),
                      Padding(
                        padding: EdgeInsets.only(top: 30.w),
                        child: Center(
                          child: Image.asset(
                            ImgAssets.eduCap,
                            width: 200.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 35.h),
                  CustomText(
                    text: 'Verification Code',
                    fontSize: 25.h,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSerif',
                    color: AppColors.themeColor,
                  ),
                  SizedBox(height: 12.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35.sp),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                            TextStyle(fontSize: 16.sp, color: AppColors.textGrey),
                        children: [
                          TextSpan(
                              text: "We’ve sent you a four digit code to\n"),
                          TextSpan(
                            text: maskInput(mobileEmailValue.toString()),
                            style: TextStyle(
                              color: AppColors.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text:
                                "Enter the code below to confirm your mobile number",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50.w,
                          child: TextField(
                            controller: codeControllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onChanged: (value) =>
                                handleInputChange(index, value),
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextButton(
                    onPressed: () async {
                      final isMobile =
                          RegExp(r'^\d+$').hasMatch(mobileEmailValue);
                      final credentials = isMobile
                          ? {'mobileNo': mobileEmailValue}
                          : {'email': mobileEmailValue};

                      try {
                        final result = await ref
                            .read(generateOtpProvider(credentials).future);

                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('OTP resent successfully')),
                          );
                        }
                      } catch (e) {
                        final errorMessage =
                            e.toString().replaceFirst('Exception: ', '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Failed to resend OTP: $errorMessage')),
                        );
                      }
                    },
                    child: CustomText(
                      text: 'Didn’t get a code? Click To Resend',
                      color: AppColors.textGrey,
                      secondaryColor: AppColors.themeColor,
                      colorSplitIndex: 19,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DMSerif',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "Verify",
                    onPressed: () async {
                      final otpCode = codeControllers.map((e) => e.text).join();

                      if (otpCode.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please enter all digits')),
                        );
                        return;
                      }

                      isLoading.value = true;

                      final isMobile =
                          RegExp(r'^\d+$').hasMatch(mobileEmailValue);
                      final credentials = isMobile
                          ? {
                              'mobileNo': mobileEmailValue,
                              'otp': otpCode,
                            }
                          : {
                              'email': mobileEmailValue,
                              'otp': otpCode,
                            };

                      try {
                        final result = await ref
                            .read(verifyOtpProvider(credentials).future);

                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('OTP Verified Successfully')),
                          );

                          NavigationHelper.replacePush(
                            context,
                            ChangePasswordView(),
                          );
                        }
                      } catch (e) {
                        final errorMessage =
                            e.toString().replaceFirst('Exception: ', '');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Verification failed: $errorMessage')),
                        );
                      } finally {
                        isLoading.value = false;
                      }
                    },
                    isLoading: isLoading.value,
                    width: ScreenUtil.defaultSize.width.sp,
                    height: 45.h,
                    borderWidth: 1.h,
                    borderColor: AppColors.themeColor,
                    backgroundColor: isFormFilled.value
                        ? AppColors.themeColor
                        : AppColors.systemWhite,
                    textColor:
                        isFormFilled.value ? AppColors.white : AppColors.themeColor,
                    fontSize: 16.h,
                    borderRadius: 30.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                      vertical: 12.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
                    child: Divider(
                      height: 0.5.h,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to Sign In
                    },
                    child: CustomText(
                      text: 'Sign In',
                      fontSize: 15.h,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

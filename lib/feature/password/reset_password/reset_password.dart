
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/password/reset_password/reset_password_provider.dart';
import 'package:e_learning/feature/password/verification_code/verify_otp_view.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:e_learning/utils/text_case_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordView extends HookConsumerWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputController = useTextEditingController(text: "9161154626");
    final isLoading = useState(false);
    final isFormFilled = useState(false);
    final selectedOption = useState('mobile');

    useEffect(() {
      void validate() {
        final input = inputController.text.trim();
        bool isValidInput = false;

        if (selectedOption.value == 'mobile') {
          isValidInput = RegExp(r'^\d{10}$').hasMatch(input);
        } else {
          isValidInput = RegExp(
              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
          ).hasMatch(input);
        }

        isFormFilled.value = isValidInput;
      }

      inputController.addListener(validate);
      validate();

      return () {
        inputController.removeListener(validate);
      };
    }, [selectedOption.value]);


    Future<void> generateOtp() async {
      isLoading.value = true;

      try {
        final credentials = selectedOption.value == 'mobile'
            ? {'mobileNo': inputController.text.trim()}
            : {'email': inputController.text.trim()};

        final result = await ref.read(generateOtpProvider(credentials).future);

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('OTP Generate Successfully')),
          );

          NavigationHelper.push(
            context,
            VerifyOtpView(mobileEmailValue: inputController.text.trim()),
          );
        }
      } catch (e) {
        final errorMessage = e.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate OTP: $errorMessage')),
        );
      } finally {
        isLoading.value = false;
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
            title: CustomText(
              text: "",
              color: AppColors.white,
              fontSize: 20.sp,
              textCase: TextCase.title,
            ),
          ),
          backgroundColor: AppColors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
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
                    text: 'Reset Password',
                    fontSize: 25.h,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSerif',
                    color: AppColors.themeColor,
                  ),
                  SizedBox(height: 30.h),

                  GestureDetector(
                    onTap: () {
                      inputController.text = "";
                      selectedOption.value = 'mobile';
                      Future.delayed(Duration.zero, () {
                        final input = inputController.text.trim();
                        final isValid = RegExp(r'^\d{10}$').hasMatch(input);
                        isFormFilled.value = isValid;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selectedOption.value == 'mobile'
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: AppColors.themeColor,
                          size: 25.sp,
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          fontSize: 18.sp,
                          text: "Send OTP On Mobile Number",
                          color: AppColors.darkGrey,
                          secondaryColor: AppColors.themeColor,
                          colorSplitIndex: 11,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),


                  GestureDetector(
                    onTap: () {
                      inputController.text = "";
                      selectedOption.value = 'email';
                      Future.delayed(Duration.zero, () {
                        final input = inputController.text.trim();
                        final isValid = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                        ).hasMatch(input);
                        isFormFilled.value = isValid;
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selectedOption.value == 'email'
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: AppColors.themeColor,
                          size: 25.sp,
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          fontSize: 18.sp,
                          text: "Send OTP On Email Address  ",
                          color: AppColors.darkGrey,
                          secondaryColor: AppColors.themeColor,
                          colorSplitIndex: 11,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: CustomTextField(
                      isEmail: selectedOption.value == 'email',
                      isMobile: selectedOption.value == 'mobile',
                      controller: inputController,
                      label: selectedOption.value == 'mobile'
                          ? 'Mobile no.'
                          : 'Email address',
                      keyboardType: selectedOption.value == 'mobile'
                          ? TextInputType.phone
                          : TextInputType.emailAddress,
                      maxLength: selectedOption.value == 'mobile' ? 10 : null,
                    ),
                  ),

                  SizedBox(height: 25.h),

                  CustomButton(
                    text: "Send OTP",
                    onPressed: () {
                      if (isFormFilled.value) {
                        generateOtp();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter valid credentials"),
                          ),
                        );
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
                    textColor: isFormFilled.value
                        ? AppColors.white
                        : AppColors.themeColor,
                    fontSize: 16.h,
                    borderRadius: 30.sp,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                      vertical: 12.sp,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
                    child: Divider(
                      height: 0.5.h,
                      color: AppColors.darkGrey,
                    ),
                  ),

                  CustomText(
                    text: 'Sign In',
                    fontSize: 15.h,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    color: AppColors.themeColor,
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




import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/login/login_view.dart';
import 'package:e_learning/feature/password/change_password/change_password_provider.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChangePasswordView extends HookConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newPassword = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final isLoading = useState(false);
    final isFormFilled = useState(false);
    final isNewPasswordVisible = useState(false);
    final isConfirmPasswordVisible = useState(false);

    useEffect(() {
      void validate() {
        isFormFilled.value =
            newPassword.text.isNotEmpty && confirmPassword.text.isNotEmpty;
      }

      newPassword.addListener(validate);
      confirmPassword.addListener(validate);
      validate();

      return () {
        newPassword.removeListener(validate);
        confirmPassword.removeListener(validate);
      };
    }, []);

    Future<void> handleChangePassword() async {
      final newPass = newPassword.text.trim();
      final confirmPass = confirmPassword.text.trim();


      if (newPass.isEmpty || confirmPass.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter both password fields")),
        );
        return;
      }

      if (newPass != confirmPass) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      isLoading.value = true;

      try {
        final result = await ref.read(changePasswordProvider({
          'newPassword': newPass,
        }).future);

        if (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password changed successfully")),
          );
          NavigationHelper.pushAndClearStack(context, LoginView());
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
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
            iconTheme: const IconThemeData(color: AppColors.white),
            backgroundColor: AppColors.themeColor,
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
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Change Password!',
                    fontSize: 25.h,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSerif',
                    color: AppColors.themeColor,
                  ),
                  SizedBox(height: 40.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: CustomTextField(
                      controller: newPassword,
                      label: 'New Password',
                      obscureText: !isNewPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isNewPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.themeColor,
                        ),
                        onPressed: () {
                          isNewPasswordVisible.value =
                          !isNewPasswordVisible.value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Confirm Password Field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: CustomTextField(
                      controller: confirmPassword,
                      label: 'Confirm Password',
                      obscureText: !isConfirmPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.themeColor,
                        ),
                        onPressed: () {
                          isConfirmPasswordVisible.value =
                          !isConfirmPasswordVisible.value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  // Submit Button
                  CustomButton(
                    text: "Change Password",
                    onPressed: () {
                      if (isFormFilled.value) {
                        handleChangePassword();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please enter valid credentials")),
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
                  SizedBox(height: 25.h),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 25.h, vertical: 20.h),
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


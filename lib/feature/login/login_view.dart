
import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/button.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:e_learning/custom_widget/text_field.dart';
import 'package:e_learning/feature/choose_account/choose_account_provider.dart';
import 'package:e_learning/feature/choose_account/choose_account_view.dart';
import 'package:e_learning/feature/login/login_provider.dart';
import 'package:e_learning/feature/password/reset_password/reset_password.dart';
import 'package:e_learning/utils/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mobileController = useTextEditingController(text: "9369997878");
    final passwordController = useTextEditingController(text: "Abc@123");
    final isLoading = useState(false);
    final isFormFilled = useState(false);
    final isPasswordVisible = useState(false);


    useEffect(() {
      void validate() {
        isFormFilled.value =
            mobileController.text.isNotEmpty && passwordController.text.isNotEmpty;
      }

      mobileController.addListener(validate);
      passwordController.addListener(validate);
      validate();

      return () {
        mobileController.removeListener(validate);
        passwordController.removeListener(validate);
      };
    }, []);

    Future<void> handleLogin() async {
      isLoading.value = true;
      try {
        final result = await ref.read(loginProvider({
          'mobileNo': mobileController.text,
          'password': passwordController.text,
        }).future);

        if (result) {
          final chooseAccountData = await ref.read(chooseAccountProvider.future);
          NavigationHelper.push(
            context,
            ChooseAccountView(chooseAccountData: chooseAccountData),
          );
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
                    text: 'Welcome Back!',
                    fontSize: 25.h,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DMSerif',
                    color: AppColors.themeColor,
                  ),
                  SizedBox(height: 40.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: CustomTextField(
                      must: false,
                      obscureText: false,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                      label: 'Mobile no.',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: !isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: Icon(
                            isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.themeColor,
                          ),
                        ),
                        onPressed: () {
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),

                  CustomButton(
                    text: "Login",
                    onPressed: () {
                      if (isFormFilled.value) {
                        handleLogin();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please enter valid credentials")),
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
                  InkWell(
                    onTap: (){
                      NavigationHelper.push(context, ResetPasswordView());
                    },
                    child: CustomText(
                      text: 'Forget Password',
                      fontSize: 15.h,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 20.h),
                    child: Divider(
                      height: 0.5.h,
                      color: AppColors.darkGrey,
                    ),
                  ),

                  CustomText(
                    text: 'Sing Up',
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

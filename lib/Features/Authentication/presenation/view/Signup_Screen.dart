import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/UI/showMyDialog.dart';
import 'package:healthforecast/Features/Authentication/presenation/manger/auth_controller.dart';
import 'package:healthforecast/data/models/user_model.dart';
import '../../../../Core/UI/primary_button.dart';
import '../../../../Core/Utils/App Colors.dart';
import '../../../../Core/Utils/App Textstyle.dart';
import '../../../../Core/Utils/Assets Manager.dart';
import '../../../../Core/Utils/Core Components.dart';
import '../../../../Core/Utils/Shared Methods.dart';
import '../../../../Core/Utils/top_snackbars.dart';
import '../../../Patient/Home/presentation/view/tabs_screen.dart';

class SignUp extends GetWidget<AuthController> {
  SignUp({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerificatioController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(),
    );
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryTop = MediaQuery.of(context).padding.top;
    final mediaQuery =
        (mediaQueryHeight - appBar.preferredSize.height - mediaQueryTop);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Hero(
                  tag: "sign",
                  child: SizedBox(
                    height: mediaQuery * 0.324,
                    child: Image.asset(
                      AssetsManager.onBoarding1,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Hero(
                      tag: "login",
                      child: Text(
                        "Sign Up ",
                        style: AppTextStyles.titleText,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(children: [
                    TextFieldTemplate(
                      name: 'FulName',
                      label: 'Enter The Full Name',
                      controller: nameController,
                      leadingIcon: Icons.supervised_user_circle_outlined,
                      boolleadingIcon: true,
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) =>
                          value!.isEmpty ? "Name is required" : null,
                    ),
                    const SizedBox(height: 15),
                    TextFieldTemplate(
                      name: 'username',
                      controller: emailController,
                      label: 'Enter The Email',
                      leadingIcon: Icons.mail_outline,
                      boolleadingIcon: true,
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email @ or .';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldTemplate(
                      name: 'age',
                      controller: ageController,
                      label: 'Enter The Age',
                      inputType: TextInputType.number,
                      leadingIcon: Icons.account_circle_outlined,
                      boolleadingIcon: true,
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Age';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldTemplate(
                      name: 'password',
                      controller: passwordController,
                      label: 'Enter The Password',
                      // leadingIcon: Iconsax.lock_1,
                      inputType: TextInputType.visiblePassword,
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 5) {
                          return 'Password must be at least 5 characters';
                        } else if (!validateStructure(value)) {
                          return 'Password must contain at least 5 characters, uppercase and lowercase letters, and special characters (@#%&*)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFieldTemplate(
                      name: 'Password Verification',
                      controller: passwordVerificatioController,
                      label: 'Enter The Confirm Password',
                      // leadingIcon: Iconsax.lock_1,
                      inputType: TextInputType.visiblePassword,
                      leadingIconColor: AppColors.greenYellow,
                      enableFocusBorder: false,
                      validator: (value) {
                        if (passwordController.text !=
                            passwordVerificatioController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Hero(
                      tag: "button",
                      child: Obx(()=>PrimaryButton(
                          label: "Sign in",
                          isLoading: controller.loading.value,
                          foregroundColor: AppColors.white,
                          backgroundColor: AppColors.blue,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if(passwordController.text == passwordVerificatioController.text){
                              var user = UserModel(
                                name: nameController.text,
                                email: emailController.text,
                                age: ageController.text,
                              );
                              controller.register(
                               user,
                                passwordController.text
                              ) ;
                            } else {
                                showCustomDialog(ontap: (){
                                  Get.back();
                                }, message: "Password does not match");
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

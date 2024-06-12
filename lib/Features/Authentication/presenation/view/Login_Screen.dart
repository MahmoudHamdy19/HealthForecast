import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Authentication/presenation/manger/auth_controller.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/forgot_password.dart';

import '../../../../Core/UI/primary_button.dart';
import '../../../../Core/Utils/App Colors.dart';
import '../../../../Core/Utils/App Textstyle.dart';
import '../../../../Core/Utils/Assets Manager.dart';
import '../../../../Core/Utils/Core Components.dart';
import '../../../../Core/Utils/Shared Methods.dart';
import 'Signup_Screen.dart';

class LoginScreen extends GetWidget<AuthController> {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
            child:Form(
             key: formKey,
             child: Column(
               children: [
                 Image.asset(
                   AssetsManager.onBoarding1,
                   fit: BoxFit.fill,
                   width: 250.0,
                 ),
                 const SizedBox(height: 10),
                 Padding(
                   padding: const EdgeInsets.all(10),
                   child: Container(
                     alignment: Alignment.topLeft,
                     child: Text(
                       "Login",
                       style: AppTextStyles.titleText,
                     ),
                   ),
                 ),
                 Column(children: [
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFieldTemplate(
                       name: 'username',
                       label: 'Enter The Email',
                       controller: emailController,
                       leadingIcon: Icons.mail_outline,
                       boolleadingIcon: true,
                       leadingIconColor: AppColors.greenYellow,
                       enableFocusBorder: false,
                       validator: (value) => value!.isEmpty
                           ? "email is required"
                           : null,
                     ),
                   ),

                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: TextFieldTemplate(
                       name: 'password',
                       controller: passwordController,
                       label: 'Enter The Password',
                       inputType: TextInputType.visiblePassword,
                       leadingIconColor: AppColors.greenYellow,
                       enableFocusBorder: false,
                       validator: (value) {
                         if (value!.isEmpty) {
                           return 'Please enter your password';
                         }
                         return null;
                       },
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
                     child: Obx(()=>PrimaryButton(
                       label: "Login",
                       isLoading:controller.loading.value,
                       foregroundColor: AppColors.white,
                       backgroundColor: AppColors.blue,
                       onPressed: () {
                         if (formKey.currentState!.validate()) {
                           controller.login(
                             emailController.text,
                             passwordController.text,
                           ) ;
                         }
                       },
                     ),
                     ),
                   ),
                   InkWell(
                     onTap: () {
                       navigateTo(context, ForgotPasswordScreen());
                     },
                     child:const Text(
                         "Forgot your password ? ",
                         style:TextStyle(fontSize: 16.0 , color: Colors.grey)
                     ),
                   ),
                   const SizedBox(
                     height: 5,
                   ),
                   InkWell(
                     onTap: () {
                       navigateTo(context, SignUp());
                     },
                     child:const Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text(
                             "You don\'t have an account? ",
                             style:TextStyle(fontSize: 16.0 , color: Colors.black)
                         ),
                         Text(
                             "Registration",
                             style:TextStyle(fontSize: 16.0 , color: AppColors.primaryColor,fontWeight: FontWeight.bold)
                         ),
                       ],
                     ),
                   ),
                 ]),
               ],
             ),
           ),
        ),
      ),
    );
  }
}

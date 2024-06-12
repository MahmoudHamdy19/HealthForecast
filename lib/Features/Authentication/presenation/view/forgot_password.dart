import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/verification_email.dart';

import '../../../../Core/UI/primary_button.dart';
import '../../../../Core/Utils/App Colors.dart';
import '../../../../Core/Utils/Assets Manager.dart';
import '../../../../Core/Utils/Core Components.dart';
import '../../../../Core/Utils/Shared Methods.dart';
import '../manger/auth_controller.dart';


class ForgotPasswordScreen extends  GetWidget<AuthController>  {

  TextEditingController emailController = TextEditingController();
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
      backgroundColor: Colors.white,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13),
        child: CustomScrollView(
          physics: const ScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: formKey,
                child: SizedBox(
                  height: mediaQuery,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Hero(
                          tag: "sign",
                          child: Image.asset(
                            AssetsManager.connection,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(height: mediaQuery * 0.01),
                      Expanded(
                          flex: 5,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Column(children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                      "to get started , first enter your email.",
                                      textAlign: TextAlign.center,
                                      style:TextStyle(fontSize: 16.0 , color: AppColors.primaryColor)
                                  ),
                                ),
                             Obx(() =>   controller.loading.value? const Center(child: CircularProgressIndicator(),)  :  Padding(
                               padding: const EdgeInsets.all(8.0),
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
                             ),),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),

                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                      "We will send a verification code to that email Check your email to get your confirmation code ",
                                      textAlign: TextAlign.center,
                                      style:TextStyle(fontSize: 16.0 , color: Colors.grey)
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width:200.0,
                                  child: Hero(
                                    tag: "button",
                                    child: PrimaryButton(
                                      label: "Next",
                                      // isLoading:state is LoginLoadingState,
                                      foregroundColor: AppColors.white,
                                      backgroundColor: AppColors.blue,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                        controller.forgetPassword(emailController.text);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  width:200.0,
                                  child: Hero(
                                    tag: "button",
                                    child: PrimaryButton(
                                      label: "Cancel",
                                      // isLoading:state is LoginLoadingState,
                                      foregroundColor: AppColors.white,
                                      backgroundColor: AppColors.blue,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * .047,
                                ),
                              ]);
                            },
                          )),
                    ],
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

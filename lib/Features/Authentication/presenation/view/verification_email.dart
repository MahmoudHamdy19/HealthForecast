import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
 import 'package:healthforecast/Core/Utils/Shared%20Methods.dart';
import 'package:healthforecast/Features/Authentication/presenation/view/Login_Screen.dart';
import '../../../../Core/UI/primary_button.dart';
 import '../../../../Core/Utils/App Colors.dart';
import '../../../../Core/Utils/Assets Manager.dart';

class VerificationEmailScreen extends StatelessWidget {
  VerificationEmailScreen({super.key});

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
                          flex: 5,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Column(children: [
                                Image.asset(AssetsManager.email,fit: BoxFit.fill,height: 200,),
                                 const SizedBox(height: 30.0,),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                      "We will send a verification url to that email Check your email.",
                                      textAlign: TextAlign.center,
                                      style:TextStyle(fontSize: 16.0 , color: Colors.grey)
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  width:200.0,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Hero(
                                    tag: "button",
                                    child: PrimaryButton(
                                      label: "Next",
                                      // isLoading:state is LoginLoadingState,
                                      foregroundColor: AppColors.white,
                                      backgroundColor: AppColors.blue,
                                      onPressed: () {
                                     navigateTo(context,LoginScreen());
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width:200.0,
                                  padding: const EdgeInsets.all(8.0),
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

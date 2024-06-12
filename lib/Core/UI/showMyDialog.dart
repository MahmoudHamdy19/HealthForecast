import 'package:flutter/cupertino.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

import '../Utils/App Colors.dart';
import '../Utils/App Textstyle.dart';
import '../Utils/Assets Manager.dart';




void showMyDialog({required BuildContext context, required Function()? ontap, required String message}) async {
    await AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    showCloseIcon: true,
    title:message ,
    titleTextStyle: AppTextStyles.titleText.copyWith(fontSize: 18),
    descTextStyle:AppTextStyles.titleText2.copyWith(fontSize: 18),
    desc: ' Are you sure you want $message ?',
    btnCancelText: "No",


    btnCancelOnPress: (){},
    btnOkText: "Yes",
    btnOkColor: AppColors.primaryColor,
    btnOkOnPress: ontap,
  ).show();
}

void showCustomDialog({BuildContext? context, required Function()? ontap, required String message ,Widget? body}) async {
    await AwesomeDialog(
    context: context??Get.context!,
    dialogType: DialogType.info,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    showCloseIcon: true,
    title:message ,
    body: body,
    titleTextStyle: AppTextStyles.titleText.copyWith(fontSize: 18),
    descTextStyle:AppTextStyles.titleText2.copyWith(fontSize: 18),
    btnCancelText: "Cancel",
    btnCancelOnPress: (){},
    btnOkText: "GO",
    btnOkColor: AppColors.primaryColor,
    btnOkOnPress: ontap,
  ).show();
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Features/Authentication/presenation/view/Login_Screen.dart';


navigateTo(BuildContext? context,screen) =>
  Navigator.of(Get.context!).push(MaterialPageRoute(builder: (_) => screen));


navigateAndReplace( context,screen) =>
   Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(builder: (_) => screen));

navigateAndFinished( context,screen) =>
  Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => screen),(route) => false);

void signout(context) {
    navigateAndFinished(context, LoginScreen());
  }
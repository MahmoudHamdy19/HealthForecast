
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/di/di.dart';
import 'package:healthforecast/firebase_options.dart';
import 'Core/Theme/LightTheme.dart';
import 'Core/Utils/Shared_preferences.dart';
import 'Features/Authentication/presenation/view/onBoarding_Screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp(widget:  OnBoardingScreen(),));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: widget,
      initialBinding: InitialBinding(),
    );
  }
}

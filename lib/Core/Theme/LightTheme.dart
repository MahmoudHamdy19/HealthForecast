import 'package:flutter/material.dart';
import '../Utils/App Colors.dart';
import '../Utils/App Textstyle.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.white,
  platform: TargetPlatform.iOS,
  primaryColor: AppColors.primarySwatch,
  canvasColor: Colors.transparent,
  iconTheme: const IconThemeData(color: AppColors.primaryColor, size: 25),
  primarySwatch: MaterialColor(0xFF22547A, {
    50: AppColors.primaryColor.withOpacity(0.05),
    100: AppColors.primaryColor.withOpacity(0.1),
    200: AppColors.primaryColor.withOpacity(0.2),
    300: AppColors.primaryColor.withOpacity(0.3),
    400: AppColors.primaryColor.withOpacity(0.4),
    500: AppColors.primaryColor.withOpacity(0.5),
    600: AppColors.primaryColor.withOpacity(0.6),
    700: AppColors.primaryColor.withOpacity(0.7),
    800: AppColors.primaryColor.withOpacity(0.8),
    900: AppColors.primaryColor.withOpacity(0.9),
  }),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    toolbarHeight: 50,
    elevation: 0,
    surfaceTintColor: AppColors.white,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColors.black),
    titleTextStyle: AppTextStyles.titleText2.copyWith(
      color: AppColors.black,
      fontSize: 24,
      fontFamily: "PTSans",
    ),


  ),
);

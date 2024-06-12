import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'App Colors.dart';

abstract class AppTextStyles {

  static TextStyle titleText = GoogleFonts.ptSans(
      fontSize: 26, color: AppColors.blue, fontWeight: FontWeight.bold);

  static TextStyle titleText2 = GoogleFonts.ptSans(
      fontSize: 30, color: Colors.black);

  static TextStyle titleText3 = GoogleFonts.ubuntu(
      fontSize: 27,
      color: AppColors.blue,
      fontWeight: FontWeight.bold);

  static TextStyle titleText4 = GoogleFonts.ptSans(
      fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle subTitle =
      GoogleFonts.ptSans(fontSize: 16, color: AppColors.darkGrey);




}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle title = GoogleFonts.roboto(
      color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.w400);

  static final TextStyle regularText = GoogleFonts.roboto(
      color: AppColors.accent, fontSize: 16, fontWeight: FontWeight.w200);

  static final TextStyle cardTitle = GoogleFonts.roboto(
      color: AppColors.secondary, fontSize: 24, fontWeight: FontWeight.w400);

  static final TextStyle sumUpTitle = GoogleFonts.roboto(
      color: AppColors.secondary, fontSize: 20, fontWeight: FontWeight.w400);

  static final TextStyle money = GoogleFonts.roboto(
      color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.w400);

  static final TextStyle cardText = GoogleFonts.roboto(
      color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w400);

  static final TextStyle cardTotalMoney = GoogleFonts.roboto(
      color: AppColors.accent, fontSize: 28, fontWeight: FontWeight.w400);

  static final TextStyle underline = GoogleFonts.roboto(
      color: AppColors.accent, fontSize: 0, fontWeight: FontWeight.w400);
}

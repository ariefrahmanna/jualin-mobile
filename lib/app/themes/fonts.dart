import 'package:flutter/material.dart';

import 'colors.dart';

class AppFonts {
  static FontWeightStyles get h1 => FontWeightStyles(fontSize: 32);
  static FontWeightStyles get h2 => FontWeightStyles(fontSize: 24);
  static FontWeightStyles get h3 => FontWeightStyles(fontSize: 18);
  static FontWeightStyles get h4 => FontWeightStyles(fontSize: 16);
  static FontWeightStyles get h5 => FontWeightStyles(fontSize: 15);
  static FontWeightStyles get h6 => FontWeightStyles(fontSize: 13);
  static FontWeightStyles get h7 => FontWeightStyles(fontSize: 12);

  static ColorStyles get button => ColorStyles();

  TextStyle get description => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
      );

  static final appBarTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: AppColors.neutral10,
  );

  static final userLink = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
    decoration: TextDecoration.underline,
  );
}

class FontWeightStyles {
  final double fontSize;

  const FontWeightStyles({required this.fontSize});

  TextStyle get regular => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.text,
      );

  TextStyle get medium => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.text,
      );

  TextStyle get semiBold => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      );

  TextStyle get bold => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: AppColors.text,
      );

  TextStyle get primary => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: AppColors.primary,
      );

  TextStyle get shade => TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: AppColors.description,
      );
}

class ColorStyles {
  const ColorStyles();

  TextStyle get primary => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral10,
      );
}

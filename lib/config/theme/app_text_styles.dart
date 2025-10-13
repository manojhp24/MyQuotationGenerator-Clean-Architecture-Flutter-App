import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/app_sizes.dart';

class   AppTextStyle {
  /// HEADINGS
  //Heading 1
  static TextStyle h1(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textXLarge(context),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  //Heading 2
  static TextStyle h2(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  //Heading 3
  static TextStyle h3(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// Body Text

  //Body Regular
  static TextStyle bodyRegular(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  //Body Small
  static TextStyle bodySmall(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w400,
    height: 1.3,
  );

  //Body Bold
  static TextStyle bodyBold(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
  );

  // Body Medium
  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context),
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
    height: 1.45,
  );


  /// Button and Labels

  //Button Text
  static TextStyle buttonText(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.8,
  );

  //Label Text
  static TextStyle label(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
  );

  ///Special Colors
  static TextStyle caption(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textSmall(context),
    color: AppColors.textTertiary,
    fontStyle: FontStyle.italic,
  );

  static TextStyle link(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textRegular(context),
    color: AppColors.accent,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );
}

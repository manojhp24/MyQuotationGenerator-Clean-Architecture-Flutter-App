import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/app_sizes.dart';

class AppTextStyle {

  /// HEADINGS

  static TextStyle h1(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textXLarge(context),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle h2(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context),
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle h3(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// NEW: Small heading (between h3 and bodyLarge)
  static TextStyle h4(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle appBarText(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context),
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
  );


  /// BODY TEXT

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle bodyRegular(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static TextStyle bodyBold(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );


  /// NEW: Used for very small metadata (timestamps, small labels)
  static TextStyle bodyExtraSmall(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context) - 2,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.2,
  );


  /// BUTTONS & LABELS

  static TextStyle buttonText(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.5,
  );

  static TextStyle label(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle navLabel(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// NEW: Tag/Chip text style
  static TextStyle tag(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );


  /// SPECIAL

  static TextStyle caption(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textSmall(context),
    fontStyle: FontStyle.italic,
    color: AppColors.textTertiary,
  );

  static TextStyle link(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
  );

  /// NEW: Hint text for TextFields
  static TextStyle hint(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
  );

  /// NEW: Numeric style (Quotation No, Price etc.)
  static TextStyle number(BuildContext context) => GoogleFonts.robotoMono(
    fontSize: AppSizes.textMedium(context),
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );
}

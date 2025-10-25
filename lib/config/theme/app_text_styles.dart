import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import '../utils/app_sizes.dart';

class AppTextStyle {
  /// HEADINGS

  // Heading 1 - Page Title / Large Heading
  static TextStyle h1(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textXLarge(context), // Usually 24-28
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.5,
  );

  // Heading 2 - AppBar Title / Medium Heading
  static TextStyle h2(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context), // Usually 20-22
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0.3,
  );

  // Heading 3 - Subheadings
  static TextStyle h3(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context), // Usually 16-18
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// BODY TEXT

  // Body Regular - Standard text
  static TextStyle bodyRegular(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context), // Usually 14
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Small - Smaller text / captions
  static TextStyle bodySmall(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context), // Usually 12
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  // Body Medium - Slightly larger for emphasis
  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context), // Usually 16
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Body Large - For bold emphasis in content
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textLarge(context), // Usually 18-20
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  // Body Bold - Bold text for emphasis
  static TextStyle bodyBold(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// BUTTON AND LABELS

  // Button Text
  static TextStyle buttonText(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textMedium(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.8,
  );

  // Label Text - small, bold labels
  static TextStyle label(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context),
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Bottom Navigation Label
  static TextStyle navLabel(BuildContext context) => GoogleFonts.nunito(
    fontSize: AppSizes.textSmall(context), // 12-13 for bottom nav
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  /// SPECIAL TEXT

  // Caption / italic small
  static TextStyle caption(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textSmall(context),
    fontStyle: FontStyle.italic,
    color: AppColors.textTertiary,
  );

  // Link Text
  static TextStyle link(BuildContext context) => GoogleFonts.lato(
    fontSize: AppSizes.textRegular(context),
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    decoration: TextDecoration.underline,
  );
}

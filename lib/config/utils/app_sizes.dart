import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/media_query_helper.dart';

class AppSizes {
  // ---------- BASE SCALE ---------- //

  static double scale(BuildContext context, double value) =>
      AppMedia.padding(context, value);

  static double w(BuildContext context, double value) =>
      AppMedia.w(context, value);

  static double h(BuildContext context, double value) =>
      AppMedia.h(context, value);

  static double text(BuildContext context, double value) =>
      AppMedia.text(context, value);


  // ---------- SPACING SYSTEM ---------- //

  static double xs(BuildContext context) => scale(context, 4);
  static double sm(BuildContext context) => scale(context, 8);
  static double md(BuildContext context) => scale(context, 16);
  static double lg(BuildContext context) => scale(context, 24);
  static double xl(BuildContext context) => scale(context, 32);

  // Page padding (outer layout spacing)
  static EdgeInsets pagePadding(BuildContext context) => EdgeInsets.symmetric(
    horizontal: w(context, 0.05),
    vertical: h(context, 0.02),
  );

  // Section-level spacing
  static double sectionVertical(BuildContext context) => h(context, 0.04);
  static double sectionHorizontal(BuildContext context) => w(context, 0.05);

  // Small spacing between related UI elements (fine-tuned layout)
  static double gapTiny(BuildContext context) => scale(context, 3);
  static double gapSmall(BuildContext context) => scale(context, 6);
  static double gapMedium(BuildContext context) => scale(context, 12);
  static double gapLarge(BuildContext context) => scale(context, 20);


  // ---------- COMPONENTS ---------- //

  // Card styling
  static double cardRadius = 16.0;
  static double cardElevation = 3.0;

  static double cardPadding(BuildContext context) => scale(context, 16);
  static double cardMargin(BuildContext context) => scale(context, 12);

  // Icon sizes
  static double iconXS(BuildContext context) => text(context, 12);
  static double iconSmall(BuildContext context) => text(context, 16);
  static double iconMedium(BuildContext context) => text(context, 24);
  static double iconLarge(BuildContext context) => text(context, 32);

  // Text sizes
  static double textXS(BuildContext context) => text(context, 10);
  static double textSmall(BuildContext context) => text(context, 12);
  static double textRegular(BuildContext context) => text(context, 14);
  static double textMedium(BuildContext context) => text(context, 16);
  static double textLarge(BuildContext context) => text(context, 20);
  static double textXLarge(BuildContext context) => text(context, 24);
  static double textXXLarge(BuildContext context) => text(context, 32);

  // Field & Button heights
  static double buttonHeight(BuildContext context) => h(context, 0.09);
  static double buttonWidth(BuildContext context) => w(context, 0.4);
  static double textFieldHeight(BuildContext context) => h(context, 0.07);
  static double appBarHeight(BuildContext context) => h(context, 0.08);

  // ---------- SAFE AREAS ---------- //
  static double topSafe(BuildContext context) => MediaQuery.of(context).padding.top;
  static double bottomSafe(BuildContext context) => MediaQuery.of(context).padding.bottom;

  // ---------- LAYOUT HELPERS ---------- //

  static double formFieldGap(BuildContext context) => gapMedium(context);
  static double titleContentGap(BuildContext context) => h(context, 0.015);
  static double iconTextGap(BuildContext context) => w(context, 0.02);
}

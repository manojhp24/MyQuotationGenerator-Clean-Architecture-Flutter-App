import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/media_query_helper.dart';

class AppSizes {
  ///Spacing (Margin & Padding)
  static double xs(BuildContext context) => AppMedia.padding(context, 4);

  static double sm(BuildContext context) => AppMedia.padding(context, 8);

  static double md(BuildContext context) => AppMedia.padding(context, 16);

  static double lg(BuildContext context) => AppMedia.padding(context, 24);

  static double xl(BuildContext context) => AppMedia.padding(context, 32);

  static EdgeInsets pagePadding(BuildContext context) => EdgeInsets.symmetric(
    horizontal: AppMedia.w(context, 0.05),
    vertical: AppMedia.h(context, 0.02),
  );

  ///Section Spacing
  //Vertical
  static double sectionVertical(BuildContext context) =>
      AppMedia.h(context, 0.04);

  //Horizontal
  static double sectionHorizontal(BuildContext context) =>
      AppMedia.w(context, 0.05);

  ///Card & Container Space
  static double cardRadius = 16.0;
  static double cardElevation = 3.0;

  static double cardPadding(BuildContext context) =>
      AppMedia.padding(context, 16);

  static double cardMargin(BuildContext context) =>
      AppMedia.padding(context, 12);

  /// Icon Sizes
  static double iconSmall(BuildContext context) => AppMedia.text(context, 16);

  static double iconMedium(BuildContext context) => AppMedia.text(context, 24);

  static double iconLarge(BuildContext context) => AppMedia.text(context, 32);

  /// Text Sizes
  static double textSmall(BuildContext context) => AppMedia.text(context, 12);

  static double textRegular(BuildContext context) => AppMedia.text(context, 14);

  static double textMedium(BuildContext context) => AppMedia.text(context, 16);

  static double textLarge(BuildContext context) => AppMedia.text(context, 20);

  static double textXLarge(BuildContext context) => AppMedia.text(context, 24);

  /// Widgets Height
  static double buttonHeight(BuildContext context) =>
      AppMedia.h(context, 0.090);

  static double textFieldHeight(BuildContext context) =>
      AppMedia.h(context, 0.07);

  static double appBarHeight(BuildContext context) => AppMedia.h(context, 0.08);

  /// Layout Helper
  static double topSafe(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomSafe(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  /// Small gap between text fields or buttons
  static double formFieldGap(BuildContext context) => AppMedia.h(context, 0.02);

  /// Gap between section title and its content
  static double titleContentGap(BuildContext context) =>
      AppMedia.h(context, 0.015);

  /// Gap between icon and text in buttons/rows
  static double iconTextGap(BuildContext context) => AppMedia.w(context, 0.02);
}

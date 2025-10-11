import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/media_query_helper.dart';

class AppSizes {

  //Spacing (Margin & Padding)
  static double xs(BuildContext context) => AppMedia.padding(context, 4);
  static double sm(BuildContext context) => AppMedia.padding(context, 8);
  static double md(BuildContext context) => AppMedia.padding(context, 16);
  static double lg(BuildContext context) => AppMedia.padding(context, 24);
  static double xl(BuildContext context) => AppMedia.padding(context, 32);


}

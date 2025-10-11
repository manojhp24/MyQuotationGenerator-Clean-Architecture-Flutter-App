import 'package:flutter/material.dart';

class AppMedia {
  //Screen Width
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  //Screen Height
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  //Dynamic Width
  static double h(BuildContext context, double value) =>
      MediaQuery.of(context).size.width * value;

  //Dynamic Height
  static double w(BuildContext context, double value) =>
      MediaQuery.of(context).size.width * value;

  //Responsive Text Sizes
  static double text(BuildContext context, double size) =>
      (MediaQuery.of(context).size.width / 375.0) * size;

  //Responsive Padding or Spacing
  static double padding(BuildContext context, double size) =>
      (MediaQuery.of(context).size.width / 375.0) * size;
}

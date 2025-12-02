import 'package:flutter/material.dart';

class QuotationInfoRow extends StatelessWidget {
  final String leftInfo;
  final String rightInfo;
  final TextStyle? leftInfoTextStyle, rightInfoTextStyle;
  final double spacing;

  const QuotationInfoRow({
    super.key,
    required this.leftInfo,
    required this.rightInfo,
    this.leftInfoTextStyle,
    this.rightInfoTextStyle,
    this.spacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: spacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftInfo, style: leftInfoTextStyle),
          Text(rightInfo, style: rightInfoTextStyle),
        ],
      ),
    );
  }
}

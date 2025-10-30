import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

void showCustomSnackBar(
    BuildContext context, {
      required String message,
      bool isSuccess = true,
      Color? backgroundColor,
      Color? textColor,
      Color? iconColor,
      Color? progressColor,
      int durationSeconds = 5,
    }) {
  final bgColor = backgroundColor ?? (isSuccess ? Colors.green.shade600 : Colors.red.shade600);
  final txtColor = textColor ?? Colors.white;
  final icnColor = iconColor ?? Colors.white;
  final barColor = progressColor ?? Colors.white;

  final icon = isSuccess ? Icons.thumb_up_alt_outlined : Icons.info;

  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: bgColor,
    margin: const EdgeInsets.all(16),
    duration: Duration(seconds: durationSeconds),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: icnColor,size: AppSizes.iconSmall(context),),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: txtColor, fontSize: 16),
              ),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Icon(Icons.close, color: txtColor.withValues(alpha: 0.8)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: 0.0),
          duration: Duration(seconds: durationSeconds),
          builder: (context, value, _) {
            return LinearProgressIndicator(
              value: value,
              color: barColor,
              backgroundColor: Colors.white24,
              minHeight: 3,
            );
          },
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

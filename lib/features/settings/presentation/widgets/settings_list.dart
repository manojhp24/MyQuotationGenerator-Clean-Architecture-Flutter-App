import 'package:flutter/material.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';

class SettingsList extends StatelessWidget {
  final IconData leadingIcon, trailingIcon;
  final String title, subTitle;
  final void Function() onTap;

  const SettingsList({
    super.key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.cardPadding(context),
          vertical: AppSizes.cardPadding(context) * 0.4,
        ),
        leading: Icon(leadingIcon, color: AppColors.primary, size: 26),
        title: Text(
          title,
          style: AppTextStyle.bodyBold(
            context,
          ).copyWith(color: AppColors.primary, fontSize: 15),
        ),
        subtitle: Text(
          subTitle,
          style: AppTextStyle.bodyLarge(context).copyWith(
            color: AppColors.primary.withValues(alpha: .6),
            fontSize: 13,
          ),
        ),
        trailing: Icon(trailingIcon),
        onTap: onTap,
      ),
    );
  }
}

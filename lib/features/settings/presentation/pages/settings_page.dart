import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/theme/app_text_styles.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_heading.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_list.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settingsAppBarTitle)),
      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingsHeading(title: AppStrings.document),

            SettingsList(
              leadingIcon: Icons.description_outlined,
              onTap: () {},
              subTitle: AppStrings.documentSettingsSubtitle,
              title: AppStrings.documentSettingsTitle,
              trailingIcon: Icons.chevron_right,
            ),
            SettingsHeading(title: AppStrings.business),

            SettingsList(
              leadingIcon: Icons.business_center_outlined,
              onTap: ()=> context.push("/add-business"),
              subTitle: AppStrings.businessInfoSubtitle,
              title: AppStrings.businessInfoTitle,
              trailingIcon: Icons.chevron_right,
            ),
          ],
        ),
      ),
    );
  }
}

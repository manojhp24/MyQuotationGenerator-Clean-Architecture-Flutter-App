import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/helpers/backup_and_restore_helper.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_heading.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_list.dart';

import '../../../../core/common/widgets/alert_dialog.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final backupHelper = BackupAndRestoreHelper(dbName: 'app_database.db');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(businessNotifyProvider.notifier).fetchBusiness();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final businessState = ref.watch(businessNotifyProvider);

    final business = businessState.businesses.isNotEmpty
        ? businessState.businesses.first
        : null;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settingsAppBarTitle,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.screenPadding(context)),
        child: ListView(
          children: [
            const SettingsHeading(title: AppStrings.document),
            SettingsList(
              leadingIcon: Icons.description_outlined,
              title: AppStrings.documentSettingsTitle,
              subTitle: AppStrings.documentSettingsSubtitle,
              onTap: () {},
            ),

            // BUSINESS
            const SettingsHeading(title: AppStrings.business),
            SettingsList(
              leadingIcon: Icons.business_center_outlined,
              title: AppStrings.businessInfoTitle,
              subTitle: AppStrings.businessInfoSubtitle,
              onTap: () async {
                final isUpdate = business != null;
                final result = await context.push(
                  isUpdate ? '/update-business' : '/add-business',
                  extra: isUpdate ? business : null,
                );
                if (result == true) {
                  ref.read(businessNotifyProvider.notifier).fetchBusiness();

                  if (context.mounted) {
                    showCustomSnackBar(
                      context,
                      message: isUpdate
                          ? "Business updated successfully"
                          : "Business added successfully",
                    );
                  }
                }
              },
            ),

            // BACKUP & RESTORE
            const SettingsHeading(title: AppStrings.backupAndRestore),
            SettingsList(
              leadingIcon: Icons.backup_outlined,
              title: AppStrings.backup,
              subTitle: AppStrings.backupSubtitle,
              onTap: () async {
                final path = await backupHelper.backupDataBase();
                if (!context.mounted) return;

                showCustomSnackBar(
                  context,
                  message: path != null
                      ? "Backup saved successfully"
                      : "Backup failed",
                  isSuccess: path != null,
                  durationSeconds: 2,
                );
              },
            ),

            SettingsList(
              leadingIcon: Icons.restore_outlined,
              title: AppStrings.restore,
              subTitle: AppStrings.restoreSubtitle,
              onTap: () async {
                final restored = await backupHelper.restoreDataBase();
                if (!context.mounted) return;

                if (restored) {
                  ref.read(customerNotifierProvider.notifier).fetchCustomer();
                }

                showCustomSnackBar(
                  context,
                  message: restored
                      ? "Database restored successfully"
                      : "Restore failed",
                  isSuccess: restored,
                  durationSeconds: 2,
                );
              },
            ),

            // DANGER ZONE
            const SettingsHeading(title: "Danger zone"),
            SettingsList(
              leadingIcon: Icons.delete_forever_outlined,
              title: "Delete Database",
              subTitle: "Remove all data permanently",
              onTap: () {
                customAlertDialog(
                  context: context,
                  scheme: scheme,
                  title: "Delete Database",
                  content:
                      "This will permanently delete all data. "
                      "This action cannot be undone.",
                  onConfirm: () async {
                    final path = await backupHelper.deleteDataBaseFile();
                    if (!context.mounted) return;

                    showCustomSnackBar(
                      context,
                      message: "Database deleted",
                      isSuccess: path != null,
                      durationSeconds: 2,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
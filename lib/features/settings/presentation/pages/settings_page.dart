import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/common/widgets/custom_app_bar.dart';
import 'package:my_quotation_generator/core/helpers/backup_and_restore_helper.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_heading.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_list.dart';

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
        showBack: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // DOCUMENT
          const SettingsHeading(title: AppStrings.document),
          SettingsList(
            leadingIcon: Icons.description_outlined,
            title: AppStrings.documentSettingsTitle,
            subTitle: AppStrings.documentSettingsSubtitle,
            trailingIcon: Icons.chevron_right,
            onTap: () {},
          ),
          // BUSINESS
          const SettingsHeading(title: AppStrings.business),
          SettingsList(
            leadingIcon: Icons.business_center_outlined,
            title: AppStrings.businessInfoTitle,
            subTitle: AppStrings.businessInfoSubtitle,
            trailingIcon: Icons.chevron_right,
            onTap: () {
              if (business == null) {
                showCustomSnackBar(
                  context,
                  message: "No business found",
                  isSuccess: false,
                  durationSeconds: 2,
                );
                return;
              }
              context.push("/update-business", extra: business);
            },
          ),

          // BACKUP & RESTORE
          const SettingsHeading(title: AppStrings.backupAndRestore),
          SettingsList(
            leadingIcon: Icons.backup_outlined,
            title: AppStrings.backup,
            subTitle: AppStrings.backupSubtitle,
            trailingIcon: Icons.chevron_right,
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
            trailingIcon: Icons.chevron_right,
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
            trailingIcon: Icons.chevron_right,
            onTap: () => _confirmDelete(context, scheme),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, ColorScheme scheme) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(Icons.warning_amber_rounded, color: scheme.error),
          title: const Text("Delete Database"),
          content: const Text(
            "This will permanently delete all data. "
            "This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: scheme.error,
                foregroundColor: scheme.onError,
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);

                final success = await backupHelper.deleteDataBaseFile();
                if (!context.mounted) return;

                if (success) {
                  ref.read(customerNotifierProvider.notifier).clearCustomers();
                }

                showCustomSnackBar(
                  context,
                  message: success
                      ? "Database deleted successfully"
                      : "Database not found",
                  isSuccess: success,
                  durationSeconds: 2,
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

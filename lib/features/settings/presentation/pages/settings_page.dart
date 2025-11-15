import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_quotation_generator/config/constants/app_strings.dart';
import 'package:my_quotation_generator/config/theme/app_colors.dart';
import 'package:my_quotation_generator/config/utils/app_sizes.dart';
import 'package:my_quotation_generator/core/common/App_snack_bar/custom_snack_bar.dart';
import 'package:my_quotation_generator/core/helpers/backup_and_restore_helper.dart';
import 'package:my_quotation_generator/features/business/presentation/provider/business_provider.dart';
import 'package:my_quotation_generator/features/customer/presentation/provider/customer_provider.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_heading.dart';
import 'package:my_quotation_generator/features/settings/presentation/widgets/settings_list.dart';

import '../../../business/domain/entities/business.dart';

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
    final businessState = ref.watch(businessNotifyProvider);
    final BusinessEntity? business = businessState.businesses.isNotEmpty
        ? businessState.businesses.first
        : null;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.settingsAppBarTitle)),
      body: Padding(
        padding: AppSizes.pagePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingsHeading(title: AppStrings.document),
            SettingsList(
              leadingIcon: Icons.description_outlined,
              onTap: () {},
              title: AppStrings.documentSettingsTitle,
              subTitle: AppStrings.documentSettingsSubtitle,
              trailingIcon: Icons.chevron_right,
            ),

            const SettingsHeading(title: AppStrings.business),
            SettingsList(
              leadingIcon: Icons.business_center_outlined,
              onTap: () {
                if (business == null) {
                  showCustomSnackBar(
                    context,
                    message: "No business found!",
                    isSuccess: false,
                  );
                  return;
                }
                context.push("/update-business", extra: business);
              },
              title: AppStrings.businessInfoTitle,
              subTitle: AppStrings.businessInfoSubtitle,
              trailingIcon: Icons.chevron_right,
            ),

            const SettingsHeading(title: AppStrings.backupAndRestore),
            SettingsList(
              leadingIcon: Icons.backup,
              onTap: () async {
                try {
                  final path = await backupHelper.backupDataBase();
                  if (context.mounted) {
                    showCustomSnackBar(
                      context,
                        durationSeconds: 2,
                      message: path != null
                          ? "Backup saved."
                          : "Backup failed.",
                      isSuccess: path != null,
                        backgroundColor: AppColors.darkGrey2
                    );
                  }
                } catch (e) {
                  if (kDebugMode) print(e);
                  if (context.mounted) {
                    showCustomSnackBar(
                      context,
                      message: "Backup failed.",
                      isSuccess: false,
                      backgroundColor: AppColors.darkGrey2,
                        durationSeconds: 2
                    );
                  }
                }
              },
              title: AppStrings.backup,
              subTitle: AppStrings.backupSubtitle,
              trailingIcon: Icons.chevron_right,
            ),

            SettingsList(
              leadingIcon: Icons.restore,
              onTap: () async {
                final restored = await backupHelper.restoreDataBase();
                if (restored) {
                  ref.read(customerNotifierProvider.notifier).fetchCustomer();
                  if (context.mounted) {
                    showCustomSnackBar(
                        context,
                        message: "Database restored.",
                        isSuccess: true,
                        backgroundColor: AppColors.darkGrey2,
                        durationSeconds: 2
                    );
                  }
                } else {
                  if (context.mounted) {
                    showCustomSnackBar(
                        context,
                        message: "Restore failed.",
                        isSuccess: false,
                        durationSeconds: 2
                    );
                  }
                }
              },
              title: AppStrings.restore,
              subTitle: AppStrings.restoreSubtitle,
              trailingIcon: Icons.chevron_right,
            ),

            SettingsList(
              leadingIcon: Icons.delete_forever,
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text(
                        "Are you sure you want to delete the entire database? "
                            "This action cannot be undone.",),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator
                                .of(dialogContext)
                                .pop(); // Closes the dialog
                          },
                        ),

                        TextButton(
                          child: const Text(
                              "Delete", style: TextStyle(color: Colors.red)),
                          onPressed: () async {
                            Navigator.of(dialogContext).pop();

                            final success = await backupHelper
                                .deleteDataBaseFile();

                            if (success == true && context.mounted) {
                              ref
                                  .read(customerNotifierProvider.notifier)
                                  .clearCustomers();

                              showCustomSnackBar(
                                context,
                                message: "Database deleted successfully.",
                                  isSuccess: true,
                                  backgroundColor: AppColors.darkGrey2,
                                  durationSeconds: 2
                              );
                            } else {
                              if (context.mounted) {
                                showCustomSnackBar(
                                    context,
                                    message: "Database not exist.",
                                    isSuccess: false,
                                    backgroundColor: AppColors.darkGrey2,
                                    durationSeconds: 2

                                );
                              }
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              title: "Delete Database",
              subTitle: "Remove all data permanently",
              trailingIcon: Icons.chevron_right,
            ),
          ],
        ),
      ),
    );
  }
}

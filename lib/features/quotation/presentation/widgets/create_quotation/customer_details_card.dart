import 'package:flutter/material.dart';
import 'package:my_quotation_generator/features/customer/domain/entities/customer.dart';

import '../../../../../config/theme/app_colors.dart';
import '../../../../../config/theme/app_text_styles.dart';
import '../../../../../config/utils/app_sizes.dart';

class CustomerDetailsCard extends StatelessWidget {
  final CustomerEntity customer;
  final VoidCallback? onRemove;

  const CustomerDetailsCard({
    super.key,
    required this.customer,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.sm(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            thickness: 0.5,
            color: AppColors.border.withValues(alpha: 0.6),
          ),

          SizedBox(height: AppSizes.sm(context)),

          /// Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 24,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(width: AppSizes.sm(context)),

              Expanded(
                child: Text(
                  customer.customerName ?? "Unknown",
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),


              if (onRemove != null)
                InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.delete, size: 18, color: AppColors.primary),
                  ),
                ),
            ],
          ),

          SizedBox(height: AppSizes.md(context)),

          /// Details
          _detailRow(
            context,
            icon: Icons.email_outlined,
            label: "Email",
            value: customer.email ?? "-",
          ),

          if (_has(customer.mobile)) ...[
            SizedBox(height: AppSizes.sm(context)),
            _detailRow(
              context,
              icon: Icons.phone_outlined,
              label: "Mobile Number",
              value: customer.mobile!,
            ),
          ],

          if (_has(customer.address1)) ...[
            SizedBox(height: AppSizes.sm(context)),
            _detailRow(
              context,
              icon: Icons.location_on_outlined,
              label: "Address",
              value: customer.address1!,
            ),
          ],

          if (_has(customer.gstIn)) ...[
            SizedBox(height: AppSizes.sm(context)),
            _detailRow(
              context,
              icon: Icons.receipt_long_outlined,
              label: "GSTIN",
              value: customer.gstIn!,
            ),
          ],

          if (_has(customer.state)) ...[
            SizedBox(height: AppSizes.sm(context)),
            _detailRow(
              context,
              icon: Icons.map_outlined,
              label: "State",
              value: customer.state!,
            ),
          ],
        ],
      ),
    );
  }

  bool _has(String? data) => data != null && data.trim().isNotEmpty;

  Widget _detailRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyle.label(
                  context,
                ).copyWith(fontSize: 11, color: AppColors.textSecondary),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: AppTextStyle.bodyRegular(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

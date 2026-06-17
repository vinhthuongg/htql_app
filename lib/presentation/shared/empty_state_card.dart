import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class EmptyStateCard extends StatelessWidget {
  const EmptyStateCard({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColor.toyotaRed, size: 24),
          ),
          SizedBox(height: 12),
          AppText(
            text: title,
            style: AppTextstyle.tsSemiBoldBlack16.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 6),
          AppText(
            text: message,
            style: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
          ),
        ],
      ),
    );
  }
}

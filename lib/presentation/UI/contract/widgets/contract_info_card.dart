import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/presentation/utils/employee_display.dart';

class ContractInfoCard extends StatelessWidget {
  const ContractInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.cardColor(context);
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColor.toyotaRed,
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 4, height: 22, color: AppColor.toyotaRed),
                    SizedBox(width: 8),
                    Icon(
                      Icons.description_outlined,
                      color: primaryTextColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    AppText(
                      text: 'Thông tin hợp đồng',
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _ContractInfoRow(
                  label: 'Số HĐ',
                  value: EmployeeDisplay.empty,
                  icon: Icons.confirmation_number_outlined,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _ContractInfoRow(
                  label: 'Loại hợp đồng',
                  value: EmployeeDisplay.empty,
                  icon: Icons.article_outlined,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _ContractInfoRow(
                  label: 'Ngày ký HĐ',
                  value: EmployeeDisplay.empty,
                  icon: Icons.edit_calendar_outlined,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _ContractInfoRow(
                  label: 'Ngày kết thúc HĐ',
                  value: EmployeeDisplay.empty,
                  icon: Icons.event_busy_outlined,
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContractInfoRow extends StatelessWidget {
  const _ContractInfoRow({
    required this.label,
    required this.value,
    required this.icon,
    required this.mutedColor,
    required this.borderColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color mutedColor;
  final Color borderColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor),
            ),
            child: Icon(icon, color: AppColor.toyotaRed, size: 20),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: label,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsRegularGrey12.copyWith(
                    color: secondaryTextColor,
                  ),
                ),
                SizedBox(height: 4),
                AppText(
                  text: value,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                    color: primaryTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

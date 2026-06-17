import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.title,
    required this.position,
    required this.department,
    required this.decisionNo,
    required this.signedDate,
    required this.effectiveDate,
    required this.status,
  });

  final String title;
  final String position;
  final String department;
  final String decisionNo;
  final String signedDate;
  final String effectiveDate;
  final String status;

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.cardColor(context);
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 4, height: 48, color: AppColor.toyotaRed),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: title,
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                        color: primaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      text: decisionNo,
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsRegularGrey12.copyWith(
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              _StatusBadge(status: status),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: mutedColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                _InfoLine(
                  label: 'Chức vụ',
                  value: position,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 8),
                _InfoLine(
                  label: 'Phòng ban',
                  value: department,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 8),
                _InfoLine(
                  label: 'Ngày ký',
                  value: signedDate,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 8),
                _InfoLine(
                  label: 'Hiệu lực',
                  value: effectiveDate,
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

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.label,
    required this.value,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final String label;
  final String value;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 76,
          child: AppText(
            text: label,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsRegularGrey12.copyWith(
              color: secondaryTextColor,
            ),
          ),
        ),
        Expanded(
          child: AppText(
            text: value,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
              color: primaryTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.toyotaRed),
      ),
      child: AppText(text: status, style: AppTextstyle.tsMediumRed12),
    );
  }
}

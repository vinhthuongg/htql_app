import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class CertificateCard extends StatelessWidget {
  const CertificateCard({
    super.key,
    required this.title,
    required this.issuer,
    required this.issuedDate,
    required this.expiredDate,
    required this.status,
  });

  final String title;
  final String issuer;
  final String issuedDate;
  final String expiredDate;
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
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.apartment_outlined,
                          color: secondaryTextColor,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Expanded(
                          child: AppText(
                            text: issuer,
                            textAlign: TextAlign.left,
                            style: AppTextstyle.tsMediumGrey14.copyWith(
                              color: secondaryTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
            child: Row(
              children: [
                Expanded(
                  child: _DateInfo(
                    label: 'Ngày cấp',
                    value: issuedDate,
                    primaryTextColor: primaryTextColor,
                    secondaryTextColor: secondaryTextColor,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _DateInfo(
                    label: 'Ngày hết hạn',
                    value: expiredDate,
                    primaryTextColor: primaryTextColor,
                    secondaryTextColor: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateInfo extends StatelessWidget {
  const _DateInfo({
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
    return Column(
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

import 'package:flutter/material.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/presentation/UI/home/widgets/stat_card.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/shared/app_avatar.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/presentation/utils/employee_display.dart';
import 'package:provider/provider.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<AuthProvider>().currentUser?.employee;
    final cardColor = AppColor.cardColor(context);
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);
    final isDarkMode = AppColor.isDarkMode(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
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
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/img_toyota.png',
                        height: 34,
                        alignment: Alignment.centerLeft,
                        color: isDarkMode ? AppColor.white : null,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: mutedColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: AppText(
                        text: _departmentName(employee),
                        style: AppTextstyle.tsMediumRed12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    AppAvatar(
                      size: 82,
                      avatarFileName: employee?.avatar,
                      borderWidth: 2,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: EmployeeDisplay.value(employee?.name),
                            textAlign: TextAlign.left,
                            style: AppTextstyle.tsBoldBlack20.copyWith(
                              color: primaryTextColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          _InformationLine(
                            iconPath: 'assets/icons/ic_rule.png',
                            text: EmployeeDisplay.value(
                              employee?.position?.name,
                            ),
                            iconColor: secondaryTextColor,
                            textColor: secondaryTextColor,
                          ),
                          SizedBox(height: 4),
                          _InformationLine(
                            iconPath: 'assets/icons/ic_cty.png',
                            text: _departmentName(employee),
                            iconColor: secondaryTextColor,
                            textColor: secondaryTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: StatCard(title: 'PHÉP CÒN', value: '--'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: StatCard(
                        title: 'ĐIỂM THƯỞNG',
                        value: EmployeeDisplay.value(employee?.rewardPoints),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _departmentName(Employee? employee) {
    return EmployeeDisplay.value(employee?.position?.department?.name);
  }
}

class _InformationLine extends StatelessWidget {
  const _InformationLine({
    required this.iconPath,
    required this.text,
    required this.iconColor,
    required this.textColor,
  });

  final String iconPath;
  final String text;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, width: 16, height: 16, color: iconColor),
        SizedBox(width: 6),
        Expanded(
          child: AppText(
            text: text,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsMediumGrey14.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}

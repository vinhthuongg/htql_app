import 'package:flutter/material.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/presentation/utils/employee_display.dart';
import 'package:provider/provider.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<AuthProvider>().currentUser?.employee;
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
                      Icons.person_outline,
                      color: primaryTextColor,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    AppText(
                      text: 'Thông tin cá nhân',
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                _InfoRow(
                  icon: Icons.phone_outlined,
                  label: 'Số điện thoại',
                  value: EmployeeDisplay.value(employee?.phone),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: _email(employee),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.cake_outlined,
                  label: 'Ngày sinh',
                  value: EmployeeDisplay.date(employee?.dateOfBirth),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.family_restroom_outlined,
                  label: 'Người thân',
                  value: EmployeeDisplay.relative(
                    name: employee?.relative,
                    phone: employee?.relativePhone,
                  ),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                ),
                SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.location_on_outlined,
                  label: 'Địa chỉ',
                  value: _address(employee),
                  mutedColor: mutedColor,
                  borderColor: borderColor,
                  primaryTextColor: primaryTextColor,
                  secondaryTextColor: secondaryTextColor,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _email(Employee? employee) {
    return EmployeeDisplay.email(
      companyEmail: employee?.companyEmail,
      personalEmail: employee?.personalEmail,
    );
  }

  String _address(Employee? employee) {
    final contactAddress = employee?.contactAddress;
    if (contactAddress != null && contactAddress.trim().isNotEmpty) {
      return EmployeeDisplay.value(contactAddress);
    }

    return EmployeeDisplay.value(employee?.permanentAddress);
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.mutedColor,
    required this.borderColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    this.maxLines = 1,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color mutedColor;
  final Color borderColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final int maxLines;

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
                  maxLines: maxLines,
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

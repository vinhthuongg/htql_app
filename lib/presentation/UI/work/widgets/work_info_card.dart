import 'package:flutter/material.dart';
import 'package:htql_app/data/models/auth/login_response.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/presentation/utils/employee_display.dart';
import 'package:provider/provider.dart';

class WorkInfoCard extends StatelessWidget {
  const WorkInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<AuthProvider>().currentUser?.employee;

    return Column(
      children: [
        _WorkSummaryCard(employee: employee),
        SizedBox(height: 16),
        _WorkSectionCard(
          title: 'Hợp đồng',
          icon: Icons.description_outlined,
          children: [
            _InfoTile(label: 'Loại hợp đồng', value: EmployeeDisplay.empty),
            _InfoTile(label: 'Ngày ký hợp đồng', value: EmployeeDisplay.empty),
            _InfoTile(
              label: 'Ngày kết thúc hợp đồng',
              value: EmployeeDisplay.empty,
            ),
          ],
        ),
        SizedBox(height: 16),
        _WorkSectionCard(
          title: 'Lương & bảo hiểm',
          icon: Icons.payments_outlined,
          children: [
            _InfoTile(label: 'Lương căn bản', value: EmployeeDisplay.empty),
            _InfoTile(label: 'Lương đóng BHXH', value: EmployeeDisplay.empty),
            _InfoTile(
              label: 'Mã số BHXH',
              value: EmployeeDisplay.value(employee?.insuranceNumber),
            ),
            _InfoTile(
              label: 'MST',
              value: EmployeeDisplay.value(employee?.taxCode),
            ),
          ],
        ),
        SizedBox(height: 16),
        _WorkSectionCard(
          title: 'Mô tả công việc',
          icon: Icons.assignment_outlined,
          children: [
            _DescriptionBox(text: EmployeeDisplay.value(employee?.job)),
          ],
        ),
      ],
    );
  }
}

class _WorkSummaryCard extends StatelessWidget {
  const _WorkSummaryCard({required this.employee});

  final Employee? employee;

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
                    Icon(Icons.work_outline, color: primaryTextColor, size: 20),
                    SizedBox(width: 8),
                    AppText(
                      text: 'Thông tin công việc',
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                        color: primaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SummaryTile(
                        label: 'Mã nhân viên',
                        value: EmployeeDisplay.value(employee?.code),
                        mutedColor: mutedColor,
                        borderColor: borderColor,
                        primaryTextColor: primaryTextColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _SummaryTile(
                        label: 'Thâm niên',
                        value: EmployeeDisplay.seniority(employee?.workDate),
                        mutedColor: mutedColor,
                        borderColor: borderColor,
                        primaryTextColor: primaryTextColor,
                        secondaryTextColor: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _InfoTile(
                  label: 'Vị trí',
                  value: EmployeeDisplay.value(employee?.position?.name),
                ),
                _InfoTile(
                  label: 'Phòng ban',
                  value: EmployeeDisplay.value(
                    employee?.position?.department?.name,
                  ),
                ),
                _InfoTile(
                  label: 'Ngày vào công ty',
                  value: EmployeeDisplay.date(employee?.workDate),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkSectionCard extends StatelessWidget {
  const _WorkSectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.cardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 22, color: AppColor.toyotaRed),
              SizedBox(width: 8),
              Icon(icon, color: primaryTextColor, size: 20),
              SizedBox(width: 8),
              AppText(
                text: title,
                textAlign: TextAlign.left,
                style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                  color: primaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.mutedColor,
    required this.borderColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final String label;
  final String value;
  final Color mutedColor;
  final Color borderColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: value,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack16.copyWith(
              color: primaryTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          AppText(
            text: label,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsRegularGrey12.copyWith(
              color: secondaryTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mutedColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText(
                text: label,
                textAlign: TextAlign.left,
                style: AppTextstyle.tsRegularGrey12.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: AppText(
                text: value,
                textAlign: TextAlign.right,
                style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                  color: primaryTextColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  const _DescriptionBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: AppText(
        text: text,
        textAlign: TextAlign.left,
        style: AppTextstyle.tsSemiBoldBlack14.copyWith(
          color: AppColor.primaryTextColor(context),
          height: 1.4,
        ),
      ),
    );
  }
}

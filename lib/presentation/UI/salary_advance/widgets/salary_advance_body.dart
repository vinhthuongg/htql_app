import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class SalaryAdvanceBody extends StatelessWidget {
  const SalaryAdvanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Ứng lương',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsBoldBlack20.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 14),
          _AdvanceLimitCard(),
          SizedBox(height: 14),
          _AdvanceRequestCard(),
          SizedBox(height: 16),
          AppButton(
            text: 'Gửi yêu cầu',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Yêu cầu ứng lương đã được ghi nhận'),
                  backgroundColor: AppColor.toyotaRed,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          AppText(
            text: 'Yêu cầu gần đây',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack16.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 12),
          _AdvanceHistoryCard(
            amount: '2.000.000đ',
            date: '15/06/2026',
            status: 'Chưa duyệt',
          ),
          SizedBox(height: 10),
          _AdvanceHistoryCard(
            amount: '1.500.000đ',
            date: '20/05/2026',
            status: 'Đã duyệt',
            isApproved: true,
          ),
        ],
      ),
    );
  }
}

class _AdvanceLimitCard extends StatelessWidget {
  const _AdvanceLimitCard();

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
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.savings_outlined,
              color: AppColor.toyotaRed,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Hạn mức có thể ứng',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsMediumGrey14.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                ),
                SizedBox(height: 4),
                AppText(
                  text: '5.000.000đ',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsBoldBlack20.copyWith(
                    color: AppColor.primaryTextColor(context),
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

class _AdvanceRequestCard extends StatelessWidget {
  const _AdvanceRequestCard();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(title: 'Thông tin ứng lương'),
          SizedBox(height: 14),
          _InputField(
            label: 'Số tiền ứng',
            hintText: 'Nhập số tiền',
            icon: Icons.payments_outlined,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 10),
          _StaticField(
            icon: Icons.event_outlined,
            label: 'Ngày nhận mong muốn',
            value: '17/06/2026',
          ),
          SizedBox(height: 10),
          _InputField(
            label: 'Lý do ứng lương',
            hintText: 'Nhập lý do',
            icon: Icons.notes_outlined,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 22, color: AppColor.toyotaRed),
        SizedBox(width: 8),
        AppText(
          text: title,
          textAlign: TextAlign.left,
          style: AppTextstyle.tsSemiBoldBlack16.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.hintText,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String hintText;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColor.toyotaRed),
        labelStyle: AppTextstyle.tsRegularGrey12.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        filled: true,
        fillColor: AppColor.mutedCardColor(context),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.borderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.toyotaRed),
        ),
      ),
    );
  }
}

class _StaticField extends StatelessWidget {
  const _StaticField({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColor.toyotaRed, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: label,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsRegularGrey12.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                ),
                SizedBox(height: 4),
                AppText(
                  text: value,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                    color: AppColor.primaryTextColor(context),
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

class _AdvanceHistoryCard extends StatelessWidget {
  const _AdvanceHistoryCard({
    required this.amount,
    required this.date,
    required this.status,
    this.isApproved = false,
  });

  final String amount;
  final String date;
  final String status;
  final bool isApproved;

  @override
  Widget build(BuildContext context) {
    final statusColor = isApproved
        ? AppColor.attendanceGreen
        : AppColor.toyotaRed;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: amount,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                ),
                SizedBox(height: 5),
                AppText(
                  text: date,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsRegularGrey12.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(6),
            ),
            child: AppText(
              text: status,
              style: AppTextstyle.tsMediumRed12.copyWith(color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}

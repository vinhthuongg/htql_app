import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class OvertimeBody extends StatelessWidget {
  const OvertimeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Tăng ca',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsBoldBlack20.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 14),
          _OvertimeSummaryCard(),
          SizedBox(height: 14),
          _OvertimeRequestCard(),
          SizedBox(height: 16),
          AppButton(
            text: 'Gửi yêu cầu',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Yêu cầu tăng ca đã được ghi nhận'),
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
          _OvertimeHistoryCard(
            date: '17/06/2026',
            time: '17:30 - 19:30',
            reason: 'Hoàn tất báo cáo hệ thống',
            status: 'Chưa duyệt',
          ),
          SizedBox(height: 10),
          _OvertimeHistoryCard(
            date: '12/06/2026',
            time: '18:00 - 20:00',
            reason: 'Hỗ trợ xử lý dữ liệu nội bộ',
            status: 'Đã duyệt',
            isApproved: true,
          ),
        ],
      ),
    );
  }
}

class _OvertimeSummaryCard extends StatelessWidget {
  const _OvertimeSummaryCard();

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
              Icons.more_time_outlined,
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
                  text: 'Tổng giờ tăng ca tháng này',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsMediumGrey14.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                ),
                SizedBox(height: 4),
                AppText(
                  text: '04 giờ',
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

class _OvertimeRequestCard extends StatelessWidget {
  const _OvertimeRequestCard();

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
          _SectionTitle(title: 'Thông tin tăng ca'),
          SizedBox(height: 14),
          _FormFieldTile(
            icon: Icons.event_outlined,
            label: 'Ngày tăng ca',
            value: '17/06/2026',
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _FormFieldTile(
                  icon: Icons.login_rounded,
                  label: 'Bắt đầu',
                  value: '17:30',
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _FormFieldTile(
                  icon: Icons.logout_rounded,
                  label: 'Kết thúc',
                  value: '19:30',
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _ReasonField(),
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

class _FormFieldTile extends StatelessWidget {
  const _FormFieldTile({
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

class _ReasonField extends StatelessWidget {
  const _ReasonField();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 4,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
      decoration: InputDecoration(
        hintText: 'Lý do tăng ca',
        hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        filled: true,
        fillColor: AppColor.mutedCardColor(context),
        contentPadding: const EdgeInsets.all(12),
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

class _OvertimeHistoryCard extends StatelessWidget {
  const _OvertimeHistoryCard({
    required this.date,
    required this.time,
    required this.reason,
    required this.status,
    this.isApproved = false,
  });

  final String date;
  final String time;
  final String reason;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  text: '$date · $time',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  style: AppTextstyle.tsMediumRed12.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          AppText(
            text: reason,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

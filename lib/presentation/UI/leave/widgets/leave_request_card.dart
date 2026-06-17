import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/leave/widgets/leave_date_range_dialog.dart';
import 'package:htql_app/presentation/provider/leave_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
      builder: (context, leaveProvider, child) {
        final cardColor = AppColor.cardColor(context);
        final borderColor = AppColor.borderColor(context);

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
              _CardTitle(
                icon: Icons.edit_calendar_outlined,
                title: 'Xin nghỉ phép',
              ),
              SizedBox(height: 14),
              _SelectionField(
                label: 'Loại nghỉ phép',
                value: leaveProvider.selectedLeaveType,
                icon: Icons.keyboard_arrow_down_rounded,
                onTap: () {
                  leaveProvider.pickLeaveType(context);
                },
              ),
              SizedBox(height: 12),
              _SelectionField(
                label: 'Chọn ngày nghỉ',
                value: leaveProvider.leaveDateText,
                icon: Icons.calendar_today_outlined,
                onTap: () {
                  leaveProvider.startDateSelection();
                  showDialog(
                    context: context,
                    builder: (context) => const LeaveDateDialog(),
                  );
                },
              ),
              if (leaveProvider.hasSelectedLeaveDate) ...[
                SizedBox(height: 12),
                _ReasonField(
                  value: leaveProvider.leaveReason,
                  onChanged: leaveProvider.setLeaveReason,
                ),
                SizedBox(height: 12),
                _LeaveDateShiftList(
                  dates: leaveProvider.selectedLeaveDates,
                  shifts: leaveProvider.shifts,
                  formatDate: leaveProvider.formatDate,
                  selectedShift: leaveProvider.selectedShift,
                  onChanged: leaveProvider.setSelectedShift,
                ),
              ],
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  leaveProvider.submitLeaveRequest(context);
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.toyotaRed,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: AppText(
                      text: 'Gửi yêu cầu',
                      style: AppTextstyle.tsSemiBoldWhite16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReasonField extends StatelessWidget {
  const _ReasonField({required this.value, required this.onChanged});

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Lý do nghỉ phép',
          textAlign: TextAlign.left,
          style: AppTextstyle.tsMediumGrey14.copyWith(
            color: secondaryTextColor,
          ),
        ),
        SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          onChanged: onChanged,
          maxLines: 3,
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: primaryTextColor,
          ),
          decoration: InputDecoration(
            hintText: 'Nhập lý do nghỉ phép',
            hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
              color: secondaryTextColor,
            ),
            filled: true,
            fillColor: mutedColor,
            contentPadding: const EdgeInsets.all(12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColor.toyotaRed),
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaveDateShiftList extends StatelessWidget {
  const _LeaveDateShiftList({
    required this.dates,
    required this.shifts,
    required this.formatDate,
    required this.selectedShift,
    required this.onChanged,
  });

  final List<DateTime> dates;
  final List<String> shifts;
  final String Function(DateTime date) formatDate;
  final String Function(DateTime date) selectedShift;
  final void Function(DateTime date, String shift) onChanged;

  @override
  Widget build(BuildContext context) {
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: 'Ngày nghỉ và ca nghỉ',
          textAlign: TextAlign.left,
          style: AppTextstyle.tsMediumGrey14.copyWith(
            color: secondaryTextColor,
          ),
        ),
        SizedBox(height: 6),
        ...dates.map(
          (date) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _LeaveDateShiftItem(
              date: date,
              shifts: shifts,
              formatDate: formatDate,
              selectedShift: selectedShift(date),
              onChanged: (shift) {
                onChanged(date, shift);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _LeaveDateShiftItem extends StatelessWidget {
  const _LeaveDateShiftItem({
    required this.date,
    required this.shifts,
    required this.formatDate,
    required this.selectedShift,
    required this.onChanged,
  });

  final DateTime date;
  final List<String> shifts;
  final String Function(DateTime date) formatDate;
  final String selectedShift;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              text: formatDate(date),
              textAlign: TextAlign.left,
              style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                color: primaryTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedShift,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.grey,
                ),
                isExpanded: true,
                dropdownColor: AppColor.cardColor(context),
                style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                  color: primaryTextColor,
                ),
                items: shifts
                    .map(
                      (shift) => DropdownMenuItem<String>(
                        value: shift,
                        child: AppText(
                          text: shift,
                          textAlign: TextAlign.left,
                          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                            color: primaryTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (shift) {
                  if (shift == null) return;
                  onChanged(shift);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final primaryTextColor = AppColor.primaryTextColor(context);

    return Row(
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
    );
  }
}

class _SelectionField extends StatelessWidget {
  const _SelectionField({
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: label,
          textAlign: TextAlign.left,
          style: AppTextstyle.tsMediumGrey14.copyWith(
            color: secondaryTextColor,
          ),
        ),
        SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: mutedColor,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
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
                Icon(icon, color: AppColor.grey, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

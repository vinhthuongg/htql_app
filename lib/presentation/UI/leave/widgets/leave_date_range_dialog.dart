import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/leave_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class LeaveDateDialog extends StatelessWidget {
  const LeaveDateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
      builder: (context, leaveProvider, child) {
        final cardColor = AppColor.cardColor(context);
        final primaryTextColor = AppColor.primaryTextColor(context);

        return Dialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 22,
                        color: AppColor.toyotaRed,
                      ),
                      SizedBox(width: 8),
                      AppText(
                        text: 'Chọn ngày nghỉ',
                        textAlign: TextAlign.left,
                        style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                          color: primaryTextColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _DateBox(
                    label: 'Ngày nghỉ đã chọn',
                    value: leaveProvider.tempLeaveDateText,
                  ),
                  if (leaveProvider.tempLeaveDates.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: leaveProvider.tempLeaveDates
                          .map(
                            (date) => _SelectedDateChip(
                              value: leaveProvider.formatDate(date),
                              onTap: () {
                                leaveProvider.selectTempDate(date);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  SizedBox(height: 14),
                  _LeaveCalendar(leaveProvider: leaveProvider),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _DialogButton(
                          title: 'Hủy',
                          isPrimary: false,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _DialogButton(
                          title: 'Áp dụng',
                          isPrimary: true,
                          onTap: () {
                            leaveProvider.applyTempLeaveDates();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LeaveCalendar extends StatelessWidget {
  const _LeaveCalendar({required this.leaveProvider});

  final LeaveProvider leaveProvider;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _CalendarIconButton(
                icon: Icons.chevron_left_rounded,
                onTap: leaveProvider.showPreviousMonth,
              ),
              Expanded(
                child: AppText(
                  text: leaveProvider.visibleMonthText,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: primaryTextColor,
                  ),
                ),
              ),
              _CalendarIconButton(
                icon: Icons.chevron_right_rounded,
                onTap: leaveProvider.showNextMonth,
              ),
            ],
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            children: [
              ...leaveProvider.weekDayLabels.map(
                (label) => Center(
                  child: AppText(
                    text: label,
                    style: AppTextstyle.tsRegularGrey12.copyWith(
                      color: secondaryTextColor,
                    ),
                  ),
                ),
              ),
              ...leaveProvider.visibleCalendarDates.map(
                (date) => _CalendarDayCell(
                  date: date,
                  isSelected:
                      date != null && leaveProvider.isTempDateSelected(date),
                  onTap: date == null
                      ? null
                      : () {
                          leaveProvider.selectTempDate(date);
                        },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalendarIconButton extends StatelessWidget {
  const _CalendarIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: SizedBox(
        height: 34,
        width: 34,
        child: Icon(icon, color: AppColor.primaryTextColor(context)),
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime? date;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (date == null) return const SizedBox.shrink();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColor.toyotaRed : AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected
                ? AppColor.toyotaRed
                : AppColor.borderColor(context),
          ),
        ),
        child: Center(
          child: AppText(
            text: date!.day.toString(),
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
              color: isSelected
                  ? AppColor.white
                  : AppColor.primaryTextColor(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedDateChip extends StatelessWidget {
  const _SelectedDateChip({required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: mutedColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              text: value,
              style: AppTextstyle.tsRegularGrey12.copyWith(
                color: primaryTextColor,
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.close_rounded, size: 14, color: secondaryTextColor),
          ],
        ),
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  const _DateBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
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
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: isPrimary ? AppColor.toyotaRed : mutedColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPrimary ? AppColor.toyotaRed : borderColor,
          ),
        ),
        child: Center(
          child: AppText(
            text: title,
            style: isPrimary
                ? AppTextstyle.tsSemiBoldWhite16
                : AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: primaryTextColor,
                  ),
          ),
        ),
      ),
    );
  }
}

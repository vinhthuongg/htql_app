import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/attendance_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class AttendanceCalendarCard extends StatelessWidget {
  const AttendanceCalendarCard({super.key, required this.days});

  final List<AttendanceDay> days;

  static const List<String> _weekDays = [
    'CN',
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Row(
              children: _weekDays
                  .map(
                    (day) => Expanded(
                      child: Container(
                        height: 42,
                        alignment: Alignment.center,
                        color: AppColor.mutedCardColor(context),
                        child: AppText(
                          text: day,
                          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                            color: AppColor.primaryTextColor(context),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.62,
            ),
            itemBuilder: (context, index) {
              return _CalendarDayCell(day: days[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({required this.day});

  final AttendanceDay day;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = AppColor.isDarkMode(context);
    final mutedTextColor = AppColor.secondaryTextColor(context);
    final currentMonthTextColor = AppColor.primaryTextColor(context);
    final inactiveTextColor = isDarkMode
        ? AppColor.darkBorder
        : AppColor.lightGrey;
    final dayColor = day.isCurrentMonth
        ? currentMonthTextColor
        : inactiveTextColor;
    final statusColor = _statusColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      decoration: BoxDecoration(
        color: day.isSelected
            ? AppColor.mutedCardColor(context)
            : AppColor.cardColor(context),
        border: Border(
          right: BorderSide(color: AppColor.borderColor(context)),
          bottom: BorderSide(color: AppColor.borderColor(context)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: day.day.toString(),
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(color: dayColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (day.checkInOut != null) ...[
            SizedBox(height: 4),
            AppText(
              text: day.checkInOut!,
              style: AppTextstyle.tsRegularGrey12.copyWith(
                color: day.isCurrentMonth
                    ? currentMonthTextColor
                    : inactiveTextColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ] else
            SizedBox(height: day.status == null ? 0 : 5),
          if (day.status != null) ...[
            SizedBox(height: 3),
            AppText(
              text: day.status!,
              style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                color: statusColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ] else if (day.checkInOut == null)
            AppText(
              text: '',
              style: AppTextstyle.tsRegularGrey12.copyWith(
                color: mutedTextColor,
              ),
            ),
        ],
      ),
    );
  }

  Color _statusColor(BuildContext context) {
    final statusColor = day.statusColor;
    if (statusColor == null) return AppColor.primaryTextColor(context);
    if (statusColor == AppColor.black) {
      return AppColor.primaryTextColor(context);
    }

    return statusColor;
  }
}

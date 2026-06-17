import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/attendance/widgets/attendance_calendar_card.dart';
import 'package:htql_app/presentation/UI/attendance/widgets/attendance_summary_card.dart';
import 'package:htql_app/presentation/provider/attendance_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class AttendanceBody extends StatelessWidget {
  const AttendanceBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(
      builder: (context, attendanceProvider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      text: 'Bảng công',
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsBoldBlack20.copyWith(
                        color: AppColor.primaryTextColor(context),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  _FilterDropdown(
                    value: attendanceProvider.selectedMonth,
                    items: attendanceProvider.months,
                    labelBuilder: (month) => 'Tháng $month',
                    onChanged: attendanceProvider.setSelectedMonth,
                  ),
                  SizedBox(width: 8),
                  _FilterDropdown(
                    value: attendanceProvider.selectedYear,
                    items: attendanceProvider.years,
                    labelBuilder: (year) => 'Năm $year',
                    onChanged: attendanceProvider.setSelectedYear,
                  ),
                ],
              ),
              SizedBox(height: 16),
              AttendanceSummaryCard(summaries: attendanceProvider.summaries),
              SizedBox(height: 18),
              AttendanceCalendarCard(days: attendanceProvider.calendarDays),
            ],
          ),
        );
      },
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
  });

  final int value;
  final List<int> items;
  final String Function(int value) labelBuilder;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          dropdownColor: AppColor.cardColor(context),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.secondaryTextColor(context),
          ),
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<int>(
                  value: item,
                  child: AppText(
                    text: labelBuilder(item),
                    style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                      color: AppColor.primaryTextColor(context),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            onChanged(value);
          },
        ),
      ),
    );
  }
}

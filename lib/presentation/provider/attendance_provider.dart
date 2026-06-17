import 'package:flutter/material.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class AttendanceSummary {
  const AttendanceSummary({
    required this.title,
    required this.code,
    required this.value,
    required this.color,
  });

  final String title;
  final String code;
  final String value;
  final Color color;
}

class AttendanceDay {
  const AttendanceDay({
    required this.day,
    this.checkInOut,
    this.status,
    this.statusColor,
    this.isCurrentMonth = true,
    this.isSelected = false,
  });

  final int day;
  final String? checkInOut;
  final String? status;
  final Color? statusColor;
  final bool isCurrentMonth;
  final bool isSelected;
}

class AttendanceProvider extends ChangeNotifier {
  final List<int> months = List<int>.generate(12, (index) => index + 1);
  final List<int> years = const [2026, 2025, 2024, 2023];

  int _selectedMonth = 6;
  int _selectedYear = 2026;

  int get selectedMonth => _selectedMonth;
  int get selectedYear => _selectedYear;

  List<AttendanceSummary> get summaries => const [
    AttendanceSummary(
      title: 'Ngày công đi làm',
      code: 'A',
      value: '11',
      color: AppColor.attendanceGreen,
    ),
    AttendanceSummary(
      title: 'Nghỉ phép',
      code: 'P',
      value: '0',
      color: AppColor.attendanceGreen,
    ),
    AttendanceSummary(
      title: 'Nghỉ phép không công',
      code: 'PK',
      value: '1',
      color: AppColor.attendanceGreen,
    ),
    AttendanceSummary(
      title: 'Nghỉ chế độ không công',
      code: 'CD',
      value: '0',
      color: AppColor.attendanceGreen,
    ),
    AttendanceSummary(
      title: 'Nghỉ không phép',
      code: 'K',
      value: '3',
      color: AppColor.attendanceWarning,
    ),
    AttendanceSummary(
      title: 'Chưa nhận việc/nghỉ việc',
      code: 'KNV',
      value: '0',
      color: AppColor.attendanceWarning,
    ),
    AttendanceSummary(
      title: 'Công tác',
      code: 'CT',
      value: '0',
      color: AppColor.attendanceOrange,
    ),
  ];

  List<AttendanceDay> get calendarDays {
    if (_selectedMonth != 6 || _selectedYear != 2026) {
      return _emptyCalendarDays();
    }

    return const [
      AttendanceDay(day: 31, isCurrentMonth: false),
      AttendanceDay(
        day: 1,
        checkInOut: '10:52 - 17:17',
        status: 'K/2',
        statusColor: AppColor.attendanceWarning,
      ),
      AttendanceDay(
        day: 2,
        checkInOut: '07:17 - 17:15',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 3,
        status: 'PK',
        statusColor: AppColor.attendanceGreen,
      ),
      AttendanceDay(
        day: 4,
        checkInOut: '07:43 - 17:32',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 5,
        checkInOut: '07:35 - 17:41',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 6,
        checkInOut: '07:44 - 17:17',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(day: 7),
      AttendanceDay(
        day: 8,
        checkInOut: '07:46 - 17:12',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 9,
        checkInOut: '07:06 - 17:09',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 10,
        checkInOut: '07:33 - 17:18',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 11,
        checkInOut: '07:38 - 17:00',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 12,
        status: 'K',
        statusColor: AppColor.attendanceWarning,
      ),
      AttendanceDay(
        day: 13,
        status: 'K',
        statusColor: AppColor.attendanceWarning,
      ),
      AttendanceDay(day: 14),
      AttendanceDay(
        day: 15,
        checkInOut: '07:40 - 17:09',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 16,
        checkInOut: '07:12 - 17:19',
        status: 'A',
        statusColor: AppColor.black,
      ),
      AttendanceDay(
        day: 17,
        checkInOut: '07:41',
        status: 'K/2',
        statusColor: AppColor.attendanceWarning,
        isSelected: true,
      ),
      AttendanceDay(day: 18),
      AttendanceDay(day: 19),
      AttendanceDay(day: 20),
      AttendanceDay(day: 21),
      AttendanceDay(day: 22),
      AttendanceDay(day: 23),
      AttendanceDay(day: 24),
      AttendanceDay(day: 25),
      AttendanceDay(day: 26),
      AttendanceDay(day: 27),
      AttendanceDay(day: 28),
      AttendanceDay(day: 29),
      AttendanceDay(day: 30),
      AttendanceDay(day: 1, isCurrentMonth: false),
      AttendanceDay(day: 2, isCurrentMonth: false),
      AttendanceDay(day: 3, isCurrentMonth: false),
      AttendanceDay(day: 4, isCurrentMonth: false),
      AttendanceDay(day: 5, isCurrentMonth: false),
      AttendanceDay(day: 6, isCurrentMonth: false),
      AttendanceDay(day: 7, isCurrentMonth: false),
      AttendanceDay(day: 8, isCurrentMonth: false),
      AttendanceDay(day: 9, isCurrentMonth: false),
      AttendanceDay(day: 10, isCurrentMonth: false),
      AttendanceDay(day: 11, isCurrentMonth: false),
    ];
  }

  void setSelectedMonth(int month) {
    _selectedMonth = month;
    notifyListeners();
  }

  void setSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  List<AttendanceDay> _emptyCalendarDays() {
    final firstDay = DateTime(_selectedYear, _selectedMonth);
    final daysInMonth = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
    final leadingDays = firstDay.weekday % 7;
    final totalCells = ((leadingDays + daysInMonth) / 7).ceil() * 7;
    final previousMonthLastDay = DateTime(_selectedYear, _selectedMonth, 0).day;

    return List.generate(totalCells, (index) {
      if (index < leadingDays) {
        return AttendanceDay(
          day: previousMonthLastDay - leadingDays + index + 1,
          isCurrentMonth: false,
        );
      }

      final day = index - leadingDays + 1;
      if (day > daysInMonth) {
        return AttendanceDay(day: day - daysInMonth, isCurrentMonth: false);
      }

      return AttendanceDay(day: day);
    });
  }
}

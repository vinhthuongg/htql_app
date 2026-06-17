import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class LeaveRequest {
  const LeaveRequest({
    required this.leaveType,
    required this.reason,
    required this.dates,
    required this.shiftByDate,
    required this.status,
  });

  final String leaveType;
  final String reason;
  final List<DateTime> dates;
  final Map<String, String> shiftByDate;
  final String status;
}

class LeaveProvider extends ChangeNotifier {
  final List<String> leaveTypes = const [
    'Nghỉ phép năm',
    'Nghỉ ốm',
    'Nghỉ việc riêng',
    'Nghỉ không lương',
  ];

  String _selectedLeaveType = 'Nghỉ phép năm';
  final List<DateTime> _selectedLeaveDates = [];
  final List<DateTime> _tempLeaveDates = [];
  final Map<String, String> _leaveShiftByDate = {};
  String _leaveReason = '';
  DateTime _visibleMonth = DateTime(DateTime.now().year, DateTime.now().month);
  final List<String> leaveFilters = const [
    'Tất cả',
    'Chưa duyệt',
    'Đã duyệt',
    'Từ chối',
    'Hủy',
  ];
  String _selectedLeaveFilter = 'Tất cả';
  final List<LeaveRequest> _leaveRequests = [];

  String get selectedLeaveType => _selectedLeaveType;
  List<DateTime> get selectedLeaveDates =>
      List.unmodifiable(_selectedLeaveDates);
  List<DateTime> get tempLeaveDates => List.unmodifiable(_tempLeaveDates);
  String get leaveReason => _leaveReason;
  String get selectedLeaveFilter => _selectedLeaveFilter;
  List<LeaveRequest> get filteredLeaveRequests {
    if (_selectedLeaveFilter == 'Tất cả') {
      return List.unmodifiable(_leaveRequests);
    }

    return List.unmodifiable(
      _leaveRequests.where((request) {
        return request.status == _selectedLeaveFilter;
      }),
    );
  }

  List<String> get shifts => const ['Cả ngày', 'Ca sáng', 'Ca chiều'];
  bool get hasSelectedLeaveDate => _selectedLeaveDates.isNotEmpty;
  DateTime get calendarSelectedDate =>
      _tempLeaveDates.isNotEmpty ? _tempLeaveDates.last : DateTime.now();
  DateTime get visibleMonth => _visibleMonth;
  String get visibleMonthText {
    final month = _visibleMonth.month.toString().padLeft(2, '0');
    return '$month/${_visibleMonth.year}';
  }

  List<String> get weekDayLabels => const [
    'T2',
    'T3',
    'T4',
    'T5',
    'T6',
    'T7',
    'CN',
  ];

  List<DateTime?> get visibleCalendarDates {
    final firstDayOfMonth = DateTime(_visibleMonth.year, _visibleMonth.month);
    final daysInMonth = DateTime(
      _visibleMonth.year,
      _visibleMonth.month + 1,
      0,
    ).day;
    final leadingEmptyDays = firstDayOfMonth.weekday - 1;
    final calendarDates = <DateTime?>[
      ...List<DateTime?>.filled(leadingEmptyDays, null),
      ...List.generate(
        daysInMonth,
        (index) => DateTime(_visibleMonth.year, _visibleMonth.month, index + 1),
      ),
    ];

    final trailingEmptyDays = (7 - calendarDates.length % 7) % 7;
    calendarDates.addAll(List<DateTime?>.filled(trailingEmptyDays, null));

    return calendarDates;
  }

  String get leaveDateText {
    if (_selectedLeaveDates.isEmpty) {
      return 'Chọn ngày nghỉ';
    }

    return _selectedLeaveDates.map(formatDate).join(', ');
  }

  void setSelectedLeaveType(String leaveType) {
    _selectedLeaveType = leaveType;
    notifyListeners();
  }

  Future<void> pickLeaveType(BuildContext context) async {
    final selectedType = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColor.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Loại nghỉ phép',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16,
                ),
                SizedBox(height: 12),
                ...leaveTypes.map(
                  (type) => InkWell(
                    onTap: () {
                      Navigator.pop(context, type);
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: type == _selectedLeaveType
                            ? AppColor.surfaceMuted
                            : AppColor.surface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: type,
                              textAlign: TextAlign.left,
                              style: AppTextstyle.tsSemiBoldBlack14,
                            ),
                          ),
                          if (type == _selectedLeaveType)
                            Icon(
                              Icons.check_rounded,
                              color: AppColor.toyotaRed,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedType == null) return;

    setSelectedLeaveType(selectedType);
  }

  void setLeaveReason(String reason) {
    _leaveReason = reason;
    notifyListeners();
  }

  void setSelectedLeaveFilter(String filter) {
    _selectedLeaveFilter = filter;
    notifyListeners();
  }

  void setSelectedShift(DateTime date, String shift) {
    _leaveShiftByDate[_dateKey(date)] = shift;
    notifyListeners();
  }

  String selectedShift(DateTime date) {
    return _leaveShiftByDate[_dateKey(date)] ?? shifts.first;
  }

  void startDateSelection() {
    _tempLeaveDates
      ..clear()
      ..addAll(_selectedLeaveDates);
    final displayDate = _tempLeaveDates.isNotEmpty
        ? _tempLeaveDates.last
        : DateTime.now();
    _visibleMonth = DateTime(displayDate.year, displayDate.month);
    notifyListeners();
  }

  void showPreviousMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month - 1);
    notifyListeners();
  }

  void showNextMonth() {
    _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + 1);
    notifyListeners();
  }

  void selectTempDate(DateTime date) {
    final selectedDate = DateTime(date.year, date.month, date.day);
    final selectedDateIndex = _tempLeaveDates.indexWhere(
      (item) => _isSameDate(item, selectedDate),
    );

    if (selectedDateIndex >= 0) {
      _tempLeaveDates.removeAt(selectedDateIndex);
    } else {
      _tempLeaveDates.add(selectedDate);
      _tempLeaveDates.sort((a, b) => a.compareTo(b));
    }

    notifyListeners();
  }

  void applyTempLeaveDates() {
    if (_tempLeaveDates.isEmpty) return;

    _selectedLeaveDates
      ..clear()
      ..addAll(_tempLeaveDates);
    _syncLeaveShiftByDate();
    notifyListeners();
  }

  void submitLeaveRequest(BuildContext context) {
    if (_selectedLeaveDates.isEmpty) {
      _showMessage(context, 'Vui lòng chọn ngày nghỉ');
      return;
    }

    if (_leaveReason.trim().isEmpty) {
      _showMessage(context, 'Vui lòng nhập lý do nghỉ phép');
      return;
    }

    _leaveRequests.insert(
      0,
      LeaveRequest(
        leaveType: _selectedLeaveType,
        reason: _leaveReason.trim(),
        dates: List.unmodifiable(_selectedLeaveDates),
        shiftByDate: Map.unmodifiable(_leaveShiftByDate),
        status: 'Chưa duyệt',
      ),
    );
    _showMessage(context, 'Gửi yêu cầu nghỉ phép thành công');
    _resetLeaveRequest();
  }

  String get tempLeaveDateText {
    if (_tempLeaveDates.isEmpty) return 'Chưa chọn ngày';
    if (_tempLeaveDates.length == 1) return formatDate(_tempLeaveDates.first);
    return _tempLeaveDates.map(formatDate).join(', ');
  }

  bool isTempDateSelected(DateTime date) {
    return _tempLeaveDates.any((item) => _isSameDate(item, date));
  }

  String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String requestDateText(LeaveRequest request) {
    return request.dates.map(formatDate).join(', ');
  }

  String requestShift(DateTime date, LeaveRequest request) {
    return request.shiftByDate[_dateKey(date)] ?? shifts.first;
  }

  bool _isSameDate(DateTime firstDate, DateTime secondDate) {
    return firstDate.year == secondDate.year &&
        firstDate.month == secondDate.month &&
        firstDate.day == secondDate.day;
  }

  String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  void _syncLeaveShiftByDate() {
    final selectedDateKeys = _selectedLeaveDates.map(_dateKey).toSet();
    _leaveShiftByDate.removeWhere((dateKey, shift) {
      return !selectedDateKeys.contains(dateKey);
    });

    for (final date in _selectedLeaveDates) {
      _leaveShiftByDate.putIfAbsent(_dateKey(date), () => shifts.first);
    }
  }

  void _resetLeaveRequest() {
    _selectedLeaveType = leaveTypes.first;
    _selectedLeaveDates.clear();
    _tempLeaveDates.clear();
    _leaveShiftByDate.clear();
    _leaveReason = '';
    notifyListeners();
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: AppText(
            text: message,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsRegularWhite14,
          ),
          backgroundColor: AppColor.charcoal,
        ),
      );
  }
}

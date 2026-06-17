class EmployeeDisplay {
  EmployeeDisplay._();

  static const String empty = 'Chưa cập nhật';

  static String value(String? value) {
    final cleanedValue = value?.trim();
    if (cleanedValue == null || cleanedValue.isEmpty) return empty;

    return cleanedValue;
  }

  static String email({String? companyEmail, String? personalEmail}) {
    return value(
      companyEmail?.isNotEmpty == true ? companyEmail : personalEmail,
    );
  }

  static String relative({String? name, String? phone}) {
    final relativeName = name?.trim();
    final relativePhone = phone?.trim();

    if ((relativeName == null || relativeName.isEmpty) &&
        (relativePhone == null || relativePhone.isEmpty)) {
      return empty;
    }

    if (relativeName == null || relativeName.isEmpty) return relativePhone!;
    if (relativePhone == null || relativePhone.isEmpty) return relativeName;

    return '$relativeName - $relativePhone';
  }

  static String date(String? value) {
    final cleanedValue = value?.trim();
    if (cleanedValue == null || cleanedValue.isEmpty) return empty;

    final parsedDate = DateTime.tryParse(cleanedValue);
    if (parsedDate == null) return cleanedValue;

    final day = parsedDate.day.toString().padLeft(2, '0');
    final month = parsedDate.month.toString().padLeft(2, '0');

    return '$day/$month/${parsedDate.year}';
  }

  static String seniority(String? workDate) {
    final parsedDate = DateTime.tryParse(workDate ?? '');
    if (parsedDate == null) return empty;

    final now = DateTime.now();
    var years = now.year - parsedDate.year;
    var months = now.month - parsedDate.month;

    if (now.day < parsedDate.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }

    if (years <= 0 && months <= 0) return 'Dưới 1 tháng';
    if (years <= 0) return '$months tháng';
    if (months <= 0) return '$years năm';

    return '$years năm $months tháng';
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  const LoginResponse({
    required this.status,
    this.accessToken,
    this.data,
    this.message,
  });

  final bool status;

  @JsonKey(name: 'access_token')
  final String? accessToken;

  final LoginUser? data;
  final String? message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginUser {
  const LoginUser({
    required this.id,
    this.idEmployee,
    this.username,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.isAdmin,
    this.accessToken,
    this.employee,
    this.permissions = const [],
  });

  final int id;

  @JsonKey(name: 'id_employee')
  final String? idEmployee;

  final String? username;
  final String? active;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'is_admin')
  final String? isAdmin;

  @JsonKey(name: 'access_token')
  final String? accessToken;

  final Employee? employee;
  final List<dynamic> permissions;

  factory LoginUser.fromJson(Map<String, dynamic> json) =>
      _$LoginUserFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserToJson(this);
}

@JsonSerializable()
class Employee {
  const Employee({
    required this.id,
    this.name,
    this.code,
    this.phone,
    this.relative,
    this.relativePhone,
    this.personalEmail,
    this.companyEmail,
    this.dateOfBirth,
    this.sex,
    this.maritalStatus,
    this.idProvince,
    this.idNumberOld,
    this.idDateOld,
    this.issuedOld,
    this.idNumberNew,
    this.idDateNew,
    this.issuedNew,
    this.permanentAddress,
    this.contactAddress,
    this.idEducation,
    this.major,
    this.schoolName,
    this.driverLicense,
    this.bankAccountNumber,
    this.bankOpenAccount,
    this.taxCode,
    this.insuranceNumber,
    this.workDate,
    this.note,
    this.userCreated,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.avatar,
    this.idPosition,
    this.job,
    this.codeTimekeeper,
    this.timekeeping,
    this.zalo,
    this.rewardPoints,
    this.position,
  });

  final int id;
  final String? name;
  final String? code;
  final String? phone;
  final String? relative;

  @JsonKey(name: 'relative_phone')
  final String? relativePhone;

  @JsonKey(name: 'personal_email')
  final String? personalEmail;

  @JsonKey(name: 'company_email')
  final String? companyEmail;

  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;

  final String? sex;

  @JsonKey(name: 'marital_status')
  final String? maritalStatus;

  @JsonKey(name: 'id_province')
  final String? idProvince;

  @JsonKey(name: 'id_number_old')
  final String? idNumberOld;

  @JsonKey(name: 'id_date_old')
  final String? idDateOld;

  @JsonKey(name: 'issued_old')
  final String? issuedOld;

  @JsonKey(name: 'id_number_new')
  final String? idNumberNew;

  @JsonKey(name: 'id_date_new')
  final String? idDateNew;

  @JsonKey(name: 'issued_new')
  final String? issuedNew;

  @JsonKey(name: 'permanent_address')
  final String? permanentAddress;

  @JsonKey(name: 'contact_address')
  final String? contactAddress;

  @JsonKey(name: 'id_education')
  final String? idEducation;

  final String? major;

  @JsonKey(name: 'school_name')
  final String? schoolName;

  @JsonKey(name: 'driver_license')
  final String? driverLicense;

  @JsonKey(name: 'bank_account_number')
  final String? bankAccountNumber;

  @JsonKey(name: 'bank_open_account')
  final String? bankOpenAccount;

  @JsonKey(name: 'tax_code')
  final String? taxCode;

  @JsonKey(name: 'insurance_number')
  final String? insuranceNumber;

  @JsonKey(name: 'work_date')
  final String? workDate;

  final String? note;

  @JsonKey(name: 'user_created')
  final String? userCreated;

  final String? active;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  final String? avatar;

  @JsonKey(name: 'id_position')
  final String? idPosition;

  final String? job;

  @JsonKey(name: 'code_timekeeper')
  final String? codeTimekeeper;

  final String? timekeeping;
  final String? zalo;

  @JsonKey(name: 'reward_points')
  final String? rewardPoints;

  final EmployeePosition? position;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}

@JsonSerializable()
class EmployeePosition {
  const EmployeePosition({
    required this.id,
    this.name,
    this.idDepartment,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.idRank,
    this.department,
  });

  final int id;
  final String? name;

  @JsonKey(name: 'id_department')
  final String? idDepartment;

  final String? active;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'id_rank')
  final String? idRank;

  final Department? department;

  factory EmployeePosition.fromJson(Map<String, dynamic> json) =>
      _$EmployeePositionFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeePositionToJson(this);
}

@JsonSerializable()
class Department {
  const Department({
    required this.id,
    this.name,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String? name;
  final String? active;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);

  Map<String, dynamic> toJson() => _$DepartmentToJson(this);
}

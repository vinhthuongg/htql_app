// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as bool,
      accessToken: json['access_token'] as String?,
      data: json['data'] == null
          ? null
          : LoginUser.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'access_token': instance.accessToken,
      'data': instance.data,
      'message': instance.message,
    };

LoginUser _$LoginUserFromJson(Map<String, dynamic> json) => LoginUser(
  id: (json['id'] as num).toInt(),
  idEmployee: json['id_employee'] as String?,
  username: json['username'] as String?,
  active: json['active'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  isAdmin: json['is_admin'] as String?,
  accessToken: json['access_token'] as String?,
  employee: json['employee'] == null
      ? null
      : Employee.fromJson(json['employee'] as Map<String, dynamic>),
  permissions: json['permissions'] as List<dynamic>? ?? const [],
);

Map<String, dynamic> _$LoginUserToJson(LoginUser instance) => <String, dynamic>{
  'id': instance.id,
  'id_employee': instance.idEmployee,
  'username': instance.username,
  'active': instance.active,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'is_admin': instance.isAdmin,
  'access_token': instance.accessToken,
  'employee': instance.employee,
  'permissions': instance.permissions,
};

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  code: json['code'] as String?,
  phone: json['phone'] as String?,
  relative: json['relative'] as String?,
  relativePhone: json['relative_phone'] as String?,
  personalEmail: json['personal_email'] as String?,
  companyEmail: json['company_email'] as String?,
  dateOfBirth: json['date_of_birth'] as String?,
  sex: json['sex'] as String?,
  maritalStatus: json['marital_status'] as String?,
  idProvince: json['id_province'] as String?,
  idNumberOld: json['id_number_old'] as String?,
  idDateOld: json['id_date_old'] as String?,
  issuedOld: json['issued_old'] as String?,
  idNumberNew: json['id_number_new'] as String?,
  idDateNew: json['id_date_new'] as String?,
  issuedNew: json['issued_new'] as String?,
  permanentAddress: json['permanent_address'] as String?,
  contactAddress: json['contact_address'] as String?,
  idEducation: json['id_education'] as String?,
  major: json['major'] as String?,
  schoolName: json['school_name'] as String?,
  driverLicense: json['driver_license'] as String?,
  bankAccountNumber: json['bank_account_number'] as String?,
  bankOpenAccount: json['bank_open_account'] as String?,
  taxCode: json['tax_code'] as String?,
  insuranceNumber: json['insurance_number'] as String?,
  workDate: json['work_date'] as String?,
  note: json['note'] as String?,
  userCreated: json['user_created'] as String?,
  active: json['active'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
  avatar: json['avatar'] as String?,
  idPosition: json['id_position'] as String?,
  job: json['job'] as String?,
  codeTimekeeper: json['code_timekeeper'] as String?,
  timekeeping: json['timekeeping'] as String?,
  zalo: json['zalo'] as String?,
  rewardPoints: json['reward_points'] as String?,
  position: json['position'] == null
      ? null
      : EmployeePosition.fromJson(json['position'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'code': instance.code,
  'phone': instance.phone,
  'relative': instance.relative,
  'relative_phone': instance.relativePhone,
  'personal_email': instance.personalEmail,
  'company_email': instance.companyEmail,
  'date_of_birth': instance.dateOfBirth,
  'sex': instance.sex,
  'marital_status': instance.maritalStatus,
  'id_province': instance.idProvince,
  'id_number_old': instance.idNumberOld,
  'id_date_old': instance.idDateOld,
  'issued_old': instance.issuedOld,
  'id_number_new': instance.idNumberNew,
  'id_date_new': instance.idDateNew,
  'issued_new': instance.issuedNew,
  'permanent_address': instance.permanentAddress,
  'contact_address': instance.contactAddress,
  'id_education': instance.idEducation,
  'major': instance.major,
  'school_name': instance.schoolName,
  'driver_license': instance.driverLicense,
  'bank_account_number': instance.bankAccountNumber,
  'bank_open_account': instance.bankOpenAccount,
  'tax_code': instance.taxCode,
  'insurance_number': instance.insuranceNumber,
  'work_date': instance.workDate,
  'note': instance.note,
  'user_created': instance.userCreated,
  'active': instance.active,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'avatar': instance.avatar,
  'id_position': instance.idPosition,
  'job': instance.job,
  'code_timekeeper': instance.codeTimekeeper,
  'timekeeping': instance.timekeeping,
  'zalo': instance.zalo,
  'reward_points': instance.rewardPoints,
  'position': instance.position,
};

EmployeePosition _$EmployeePositionFromJson(Map<String, dynamic> json) =>
    EmployeePosition(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      idDepartment: json['id_department'] as String?,
      active: json['active'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      idRank: json['id_rank'] as String?,
      department: json['department'] == null
          ? null
          : Department.fromJson(json['department'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmployeePositionToJson(EmployeePosition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'id_department': instance.idDepartment,
      'active': instance.active,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id_rank': instance.idRank,
      'department': instance.department,
    };

Department _$DepartmentFromJson(Map<String, dynamic> json) => Department(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  active: json['active'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$DepartmentToJson(Department instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

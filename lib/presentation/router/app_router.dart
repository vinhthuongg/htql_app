import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/appointment/appointment_screen.dart';
import 'package:htql_app/presentation/UI/attendance/attendance_screen.dart';
import 'package:htql_app/presentation/UI/bottomnav/bottomnav.dart';
import 'package:htql_app/presentation/UI/certificate/certificate_screen.dart';
import 'package:htql_app/presentation/UI/change_password/change_password_screen.dart';
import 'package:htql_app/presentation/UI/contract/contract_screen.dart';
import 'package:htql_app/presentation/UI/docs/docs_screen.dart';
import 'package:htql_app/presentation/UI/event/event_sreen.dart';
import 'package:htql_app/presentation/UI/feedback/feedback_screen.dart';
import 'package:htql_app/presentation/UI/leave/leave_screen.dart';
import 'package:htql_app/presentation/UI/login/login_screen.dart';
import 'package:htql_app/presentation/UI/home/home_screen.dart';
import 'package:htql_app/presentation/UI/notification/notification_screen.dart';
import 'package:htql_app/presentation/UI/overtime/overtime_screen.dart';
import 'package:htql_app/presentation/UI/personal/personal_screen.dart';
import 'package:htql_app/presentation/UI/reward/reward_screen.dart';
import 'package:htql_app/presentation/UI/salary_advance/salary_advance_screen.dart';
import 'package:htql_app/presentation/UI/salary/salary_screen.dart';
import 'package:htql_app/presentation/UI/setting/setting_screen.dart';
import 'package:htql_app/presentation/UI/transfer/transfer_screen.dart';
import 'package:htql_app/presentation/UI/work/work_screen.dart';

class AppRouter {
  //
  static const String loginScreen = '/loginscreen';
  static const String homeScreen = '/homescreen';
  static const String docsScreen = '/docsscreen';
  static const String eventScreen = '/eventscreen';
  static const String leaveScreen = '/leavescreen';
  static const String bottomNav = '/bottomnav';
  static const String personalScreen = '/personalscreen';
  static const String workScreen = '/workscreen';
  static const String contractScreen = '/contractscreen';
  static const String certificateScreen = '/certificatescreen';
  static const String transferScreen = '/transferscreen';
  static const String appointmentScreen = '/appointmentscreen';
  static const String rewardScreen = '/rewardscreen';
  static const String attendanceScreen = '/attendancescreen';
  static const String salaryScreen = '/salaryscreen';
  static const String salaryAdvanceScreen = '/salaryadvancescreen';
  static const String feedbackScreen = '/feedbackscreen';
  static const String settingScreen = '/settingscreen';
  static const String changePasswordScreen = '/changepasswordscreen';
  static const String notificationScreen = '/notificationscreen';
  static const String overtimeScreen = '/overtimescreen';

  Map<String, Widget Function(BuildContext context)> routes =
      <String, WidgetBuilder>{
        AppRouter.loginScreen: (context) => const LoginScreen(),
        AppRouter.homeScreen: (context) => const HomeScreen(),
        AppRouter.leaveScreen: (context) => const LeaveScreen(),
        AppRouter.eventScreen: (context) => const EventSreen(),
        AppRouter.docsScreen: (context) => const DocsScreen(),
        AppRouter.bottomNav: (context) => const BottomNav(),
        AppRouter.personalScreen: (context) => const PersonalScreen(),
        AppRouter.workScreen: (context) => const WorkScreen(),
        AppRouter.contractScreen: (context) => const ContractScreen(),
        AppRouter.certificateScreen: (context) => const CertificateScreen(),
        AppRouter.transferScreen: (context) => const TransferScreen(),
        AppRouter.appointmentScreen: (context) => const AppointmentScreen(),
        AppRouter.rewardScreen: (context) => const RewardScreen(),
        AppRouter.attendanceScreen: (context) => const AttendanceScreen(),
        AppRouter.salaryScreen: (context) => const SalaryScreen(),
        AppRouter.salaryAdvanceScreen: (context) => const SalaryAdvanceScreen(),
        AppRouter.feedbackScreen: (context) => const FeedbackScreen(),
        AppRouter.settingScreen: (context) => const SettingScreen(),
        AppRouter.changePasswordScreen: (context) =>
            const ChangePasswordScreen(),
        AppRouter.notificationScreen: (context) => const NotificationScreen(),
        AppRouter.overtimeScreen: (context) => const OvertimeScreen(),
      };
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/attendance/widgets/attendance_body.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: AttendanceBody()),
    );
  }
}

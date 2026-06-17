import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/leave/widgets/leave_body.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: LeaveBody()),
    );
  }
}

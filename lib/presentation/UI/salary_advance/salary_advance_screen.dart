import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/salary_advance/widgets/salary_advance_body.dart';

class SalaryAdvanceScreen extends StatelessWidget {
  const SalaryAdvanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: SalaryAdvanceBody()),
    );
  }
}

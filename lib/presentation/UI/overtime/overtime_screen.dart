import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/overtime/widgets/overtime_body.dart';

class OvertimeScreen extends StatelessWidget {
  const OvertimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: OvertimeBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/appointment/widgets/appointment_body.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: AppointmentBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/change_password/widgets/change_password_body.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: ChangePasswordBody()),
    );
  }
}

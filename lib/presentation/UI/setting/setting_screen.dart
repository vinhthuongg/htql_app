import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/setting/widgets/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: SettingBody()),
    );
  }
}

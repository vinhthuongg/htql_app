import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/notification/widgets/notification_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: NotificationBody()),
    );
  }
}

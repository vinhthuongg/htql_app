import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/work/widgets/work_body.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: WorkBody()),
    );
  }
}

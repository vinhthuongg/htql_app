import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/reward/widgets/reward_body.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: RewardBody()),
    );
  }
}

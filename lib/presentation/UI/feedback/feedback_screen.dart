import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/feedback/widgets/feedback_body.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: SafeArea(child: FeedbackBody()),
    );
  }
}

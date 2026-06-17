import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/personal/widgets/personal_body.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: PersonalBody()),
    );
  }
}

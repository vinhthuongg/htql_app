import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/personal/widgets/personal_info_card.dart';

class PersonalBody extends StatelessWidget {
  const PersonalBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(children: [PersonalInfoCard()]),
    );
  }
}

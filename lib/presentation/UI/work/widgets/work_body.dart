import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/work/widgets/work_info_card.dart';

class WorkBody extends StatelessWidget {
  const WorkBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(children: [WorkInfoCard()]),
    );
  }
}

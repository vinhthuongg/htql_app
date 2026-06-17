import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/contract/widgets/contract_info_card.dart';

class ContractBody extends StatelessWidget {
  const ContractBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(children: [ContractInfoCard()]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/contract/widgets/contract_body.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: ContractBody()),
    );
  }
}

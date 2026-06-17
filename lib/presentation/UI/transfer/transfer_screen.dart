import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/transfer/widgets/transfer_body.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: TransferBody()),
    );
  }
}

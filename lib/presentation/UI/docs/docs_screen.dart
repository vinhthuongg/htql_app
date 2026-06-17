import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/docs/widgets/docs_body.dart';

class DocsScreen extends StatelessWidget {
  const DocsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: DocsBody()),
    );
  }
}

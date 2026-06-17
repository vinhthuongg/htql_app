import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/certificate/widgets/certificate_body.dart';

class CertificateScreen extends StatelessWidget {
  const CertificateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(child: CertificateBody()),
    );
  }
}

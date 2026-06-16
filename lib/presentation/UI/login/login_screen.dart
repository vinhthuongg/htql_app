import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody()
    );
  }

  Widget _buildBody(){
    return Column(
      children: [
        Text('Login Screen')
      ],
    );
  }
}
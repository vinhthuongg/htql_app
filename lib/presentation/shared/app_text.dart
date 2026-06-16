import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';

class AppText extends StatelessWidget {
  final TextAlign? textAlign;
  final String text;
  final TextStyle? style;
  const AppText({super.key, required this.text, this.textAlign,this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, 
    textAlign: textAlign ?? TextAlign.center, 
    style: style ?? AppTextstyle.tsRegularBlack16,);
  }
}
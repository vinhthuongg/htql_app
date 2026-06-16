import 'package:flutter/material.dart';

class WidgetTextformfield extends StatelessWidget {
  final String hintText;
  const WidgetTextformfield({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFC62828)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFF000000)),
        ),
        border: OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}
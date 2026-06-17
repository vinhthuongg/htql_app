import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.elevatedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      height: 96,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '$value\n', style: AppTextstyle.tsBoldRed28),
              TextSpan(
                text: title,
                style: AppTextstyle.tsRegularGrey12.copyWith(
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

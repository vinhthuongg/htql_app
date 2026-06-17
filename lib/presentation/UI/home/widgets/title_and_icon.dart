import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class TitleAndIcon extends StatelessWidget {
  const TitleAndIcon({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? AppColor.white : AppColor.charcoal;

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(width: 4, height: 22, color: AppColor.toyotaRed),
          SizedBox(width: 8),
          Icon(icon, color: textColor, size: 20),
          SizedBox(width: 8),
          AppText(
            text: title,
            style: AppTextstyle.tsSemiBoldBlack16.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}

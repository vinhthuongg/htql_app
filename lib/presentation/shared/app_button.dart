import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  const AppButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.toyotaRed,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextstyle.tsSemiBoldBlack16.copyWith(
              color: AppColor.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.elevatedCardColor(context);
    final mutedColor = AppColor.isDarkMode(context)
        ? AppColor.darkSurfaceMuted
        : AppColor.surfaceMuted;
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 92,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: mutedColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: borderColor),
              ),
              child: Icon(icon, color: AppColor.toyotaRed, size: 20),
            ),
            SizedBox(height: 10),
            AppText(
              text: title,
              style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                fontSize: 12,
                color: primaryTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.buttons});

  final List<Widget> buttons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.isDarkMode(context)
            ? AppColor.darkSurface
            : AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 20) / 3;

          return Wrap(
            spacing: 10,
            runSpacing: 10,
            children: buttons
                .map((button) => SizedBox(width: itemWidth, child: button))
                .toList(),
          );
        },
      ),
    );
  }
}

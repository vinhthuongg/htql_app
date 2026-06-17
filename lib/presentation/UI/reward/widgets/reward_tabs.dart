import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/reward_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class RewardTabs extends StatelessWidget {
  const RewardTabs({super.key, required this.rewardProvider});

  final RewardProvider rewardProvider;

  @override
  Widget build(BuildContext context) {
    final icons = [
      Icons.workspace_premium_outlined,
      Icons.error_outline_rounded,
      Icons.shopping_bag_outlined,
      Icons.history_rounded,
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(rewardProvider.tabs.length, (index) {
        final isSelected = rewardProvider.selectedTabIndex == index;

        return InkWell(
          onTap: () {
            rewardProvider.setSelectedTabIndex(index);
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.toyotaRed
                  : AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isSelected
                    ? AppColor.toyotaRed
                    : AppColor.borderColor(context),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icons[index],
                  color: isSelected
                      ? AppColor.white
                      : AppColor.primaryTextColor(context),
                  size: 18,
                ),
                SizedBox(width: 8),
                AppText(
                  text: rewardProvider.tabs[index],
                  style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                    color: isSelected
                        ? AppColor.white
                        : AppColor.primaryTextColor(context),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

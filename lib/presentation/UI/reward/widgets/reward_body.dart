import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/reward/widgets/reward_filter_table.dart';
import 'package:htql_app/presentation/UI/reward/widgets/reward_summary_card.dart';
import 'package:htql_app/presentation/UI/reward/widgets/reward_tabs.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/provider/reward_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class RewardBody extends StatelessWidget {
  const RewardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardProvider>(
      builder: (context, rewardProvider, child) {
        final rewardPoints =
            context.watch<AuthProvider>().currentUser?.employee?.rewardPoints ??
            '0';

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      text: 'Khen thưởng - Kỷ luật',
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsBoldBlack20.copyWith(
                        color: AppColor.primaryTextColor(context),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  _YearDropdown(rewardProvider: rewardProvider),
                ],
              ),
              SizedBox(height: 16),
              RewardSummaryCard(
                rewardProvider: rewardProvider,
                rewardPoints: rewardPoints,
              ),
              SizedBox(height: 18),
              RewardTabs(rewardProvider: rewardProvider),
              SizedBox(height: 14),
              RewardFilterTable(rewardProvider: rewardProvider),
            ],
          ),
        );
      },
    );
  }
}

class _YearDropdown extends StatelessWidget {
  const _YearDropdown({required this.rewardProvider});

  final RewardProvider rewardProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: rewardProvider.selectedYear,
          dropdownColor: AppColor.cardColor(context),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.primaryTextColor(context),
          ),
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
          items: rewardProvider.years
              .map(
                (year) => DropdownMenuItem<int>(
                  value: year,
                  child: AppText(
                    text: year.toString(),
                    style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                      color: AppColor.primaryTextColor(context),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (year) {
            if (year == null) return;
            rewardProvider.setSelectedYear(year);
          },
        ),
      ),
    );
  }
}

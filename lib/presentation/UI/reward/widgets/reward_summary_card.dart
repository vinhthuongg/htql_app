import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/reward_provider.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class RewardSummaryCard extends StatelessWidget {
  const RewardSummaryCard({
    super.key,
    required this.rewardProvider,
    required this.rewardPoints,
  });

  final RewardProvider rewardProvider;
  final String rewardPoints;

  @override
  Widget build(BuildContext context) {
    final year = rewardProvider.selectedYear;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  value: rewardProvider.rewardCount.toString(),
                  label: 'Tổng khen thưởng năm $year',
                  showRightBorder: true,
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  value: rewardProvider.disciplineCount.toString(),
                  label: 'Tổng kỷ luật năm $year',
                ),
              ),
            ],
          ),
          Divider(height: 1, color: AppColor.borderColor(context)),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  value: rewardPoints,
                  label: 'Điểm tích lũy',
                  showRightBorder: true,
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  value: rewardPoints,
                  label: 'Điểm năm $year',
                  showRightBorder: true,
                ),
              ),
              Expanded(
                child: _SummaryItem(
                  value: rewardPoints,
                  label: 'Điểm đổi quà còn lại',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.value,
    required this.label,
    this.showRightBorder = false,
  });

  final String value;
  final String label;
  final bool showRightBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        border: showRightBorder
            ? Border(right: BorderSide(color: AppColor.borderColor(context)))
            : null,
      ),
      child: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$value\n',
                style: AppTextstyle.tsBoldRed28.copyWith(
                  color: AppColor.primaryTextColor(context),
                ),
              ),
              TextSpan(
                text: label,
                style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                  color: AppColor.primaryTextColor(context),
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

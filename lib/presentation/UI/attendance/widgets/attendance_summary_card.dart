import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/attendance_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class AttendanceSummaryCard extends StatelessWidget {
  const AttendanceSummaryCard({super.key, required this.summaries});

  final List<AttendanceSummary> summaries;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        children: summaries
            .map(
              (summary) => _SummaryRow(
                summary: summary,
                showDivider: summary != summaries.last,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.summary, required this.showDivider});

  final AttendanceSummary summary;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: AppColor.borderColor(context)))
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: summary.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: AppText(
              text: '${summary.title} (${summary.code})',
              textAlign: TextAlign.left,
              style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                color: AppColor.primaryTextColor(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 12),
          AppText(
            text: summary.value,
            textAlign: TextAlign.right,
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
              color: summary.color,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/leave_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class LeaveFilterCard extends StatelessWidget {
  const LeaveFilterCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveProvider>(
      builder: (context, leaveProvider, child) {
        final cardColor = AppColor.cardColor(context);
        final borderColor = AppColor.borderColor(context);
        final primaryTextColor = AppColor.primaryTextColor(context);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(width: 4, height: 22, color: AppColor.toyotaRed),
                  SizedBox(width: 8),
                  Icon(
                    Icons.filter_list_rounded,
                    color: primaryTextColor,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  AppText(
                    text: 'Bộ lọc phép',
                    textAlign: TextAlign.left,
                    style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                      color: primaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: leaveProvider.leaveFilters
                    .map(
                      (filter) => _FilterChip(
                        label: filter,
                        isSelected: filter == leaveProvider.selectedLeaveFilter,
                        onTap: () {
                          leaveProvider.setSelectedLeaveFilter(filter);
                        },
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 14),
              if (leaveProvider.filteredLeaveRequests.isEmpty)
                _EmptyLeaveRequest()
              else
                ...leaveProvider.filteredLeaveRequests.map(
                  (request) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _LeaveRequestItem(
                      request: request,
                      formatDate: leaveProvider.formatDate,
                      requestShift: leaveProvider.requestShift,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyLeaveRequest extends StatelessWidget {
  const _EmptyLeaveRequest();

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: AppText(
        text: 'Chưa có yêu cầu nghỉ phép',
        textAlign: TextAlign.left,
        style: AppTextstyle.tsMediumGrey14.copyWith(color: secondaryTextColor),
      ),
    );
  }
}

class _LeaveRequestItem extends StatelessWidget {
  const _LeaveRequestItem({
    required this.request,
    required this.formatDate,
    required this.requestShift,
  });

  final LeaveRequest request;
  final String Function(DateTime date) formatDate;
  final String Function(DateTime date, LeaveRequest request) requestShift;

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.cardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 4, height: 42, color: AppColor.toyotaRed),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: request.leaveType,
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                        color: primaryTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    AppText(
                      text: request.reason,
                      textAlign: TextAlign.left,
                      style: AppTextstyle.tsMediumGrey14.copyWith(
                        color: secondaryTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              _StatusBadge(status: request.status),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: request.dates
                .map(
                  (date) => _DateShiftChip(
                    dateText: formatDate(date),
                    shiftText: requestShift(date, request),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DateShiftChip extends StatelessWidget {
  const _DateShiftChip({required this.dateText, required this.shiftText});

  final String dateText;
  final String shiftText;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);
    final secondaryTextColor = AppColor.secondaryTextColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: mutedColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: dateText,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
              color: primaryTextColor,
            ),
          ),
          SizedBox(height: 2),
          AppText(
            text: shiftText,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsRegularGrey12.copyWith(
              color: secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.toyotaRed),
      ),
      child: AppText(text: status, style: AppTextstyle.tsMediumRed12),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final mutedColor = AppColor.mutedCardColor(context);
    final borderColor = AppColor.borderColor(context);
    final primaryTextColor = AppColor.primaryTextColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.toyotaRed : mutedColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColor.toyotaRed : borderColor,
          ),
        ),
        child: AppText(
          text: label,
          style: isSelected
              ? AppTextstyle.tsRegularWhite14.copyWith(
                  fontWeight: FontWeight.w600,
                )
              : AppTextstyle.tsSemiBoldBlack14.copyWith(
                  color: primaryTextColor,
                ),
        ),
      ),
    );
  }
}

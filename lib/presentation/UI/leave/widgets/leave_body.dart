import 'package:flutter/material.dart';
import 'package:htql_app/presentation/UI/leave/widgets/leave_balance_card.dart';
import 'package:htql_app/presentation/UI/leave/widgets/leave_filter_card.dart';
import 'package:htql_app/presentation/UI/leave/widgets/leave_request_card.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class LeaveBody extends StatelessWidget {
  const LeaveBody({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryTextColor = AppColor.primaryTextColor(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 56, 16, 24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text: 'Nghỉ Phép',
              style: AppTextstyle.tsBoldBlack20.copyWith(color: primaryTextColor),
            ),
          ),
          SizedBox(height: 14,),
          LeaveBalanceCard(),
          SizedBox(height: 16),
          LeaveRequestCard(),
          SizedBox(height: 16),
          LeaveFilterCard(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/empty_state_card.dart';

class AppointmentBody extends StatelessWidget {
  const AppointmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: const [
          EmptyStateCard(
            title: 'Chưa có bổ nhiệm',
            message: 'Dữ liệu bổ nhiệm chưa có trong thông tin đăng nhập.',
            icon: Icons.add_circle_outline,
          ),
        ],
      ),
    );
  }
}

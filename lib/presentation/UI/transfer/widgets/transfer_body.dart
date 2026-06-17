import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/empty_state_card.dart';

class TransferBody extends StatelessWidget {
  const TransferBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: const [
          EmptyStateCard(
            title: 'Chưa có luân chuyển',
            message: 'Dữ liệu luân chuyển chưa có trong thông tin đăng nhập.',
            icon: Icons.sync_outlined,
          ),
        ],
      ),
    );
  }
}

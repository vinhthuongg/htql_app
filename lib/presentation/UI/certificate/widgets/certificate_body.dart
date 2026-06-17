import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/empty_state_card.dart';

class CertificateBody extends StatelessWidget {
  const CertificateBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: const [
          EmptyStateCard(
            title: 'Chưa có chứng chỉ',
            message: 'Dữ liệu chứng chỉ chưa có trong thông tin đăng nhập.',
            icon: Icons.badge_outlined,
          ),
        ],
      ),
    );
  }
}

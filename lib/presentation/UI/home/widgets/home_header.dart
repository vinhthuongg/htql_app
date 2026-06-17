import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/theme_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final titleColor = AppColor.primaryTextColor(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              AppText(
                text: 'Toyota Kiên Giang',
                textAlign: TextAlign.left,
                style: AppTextstyle.tsMediumRed12,
              ),
              SizedBox(height: 4),
              AppText(
                text: 'Xin chào, Nguyễn Văn A',
                textAlign: TextAlign.left,
                style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                  color: titleColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return _HeaderIconButton(
              icon: themeProvider.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              onTap: themeProvider.toggleDarkMode,
            );
          },
        ),
        SizedBox(width: 8),
        _HeaderIconButton(icon: Icons.notifications_none_rounded, onTap: () {}),
        SizedBox(width: 8),
        PopupMenuButton<String>(
          color: AppColor.cardColor(context),
          elevation: 8,
          offset: const Offset(0, 44),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onSelected: (value) {},
          itemBuilder: (context) => [
            _buildMenuItem(
              context: context,
              value: 'profile',
              icon: Icons.person_outline,
              title: 'Trang cá nhân',
            ),
            _buildMenuItem(
              context: context,
              value: 'change_password',
              icon: Icons.lock_outline,
              title: 'Đổi mật khẩu',
            ),
            _buildMenuItem(
              context: context,
              value: 'logout',
              icon: Icons.logout_rounded,
              title: 'Đăng xuất',
              isDestructive: true,
            ),
          ],
          child: Container(
            height: 42,
            width: 42,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.toyotaRed),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/img_avatar.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem({
    required BuildContext context,
    required String value,
    required IconData icon,
    required String title,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? AppColor.toyotaRed
        : AppColor.primaryTextColor(context);

    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 10),
          AppText(
            text: title,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColor.cardColor(context);
    final borderColor = AppColor.borderColor(context);
    final iconColor = AppColor.primaryTextColor(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

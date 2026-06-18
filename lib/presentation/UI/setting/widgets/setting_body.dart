import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/auth_provider.dart';
import 'package:htql_app/presentation/provider/theme_provider.dart';
import 'package:htql_app/presentation/provider/weather_reminder_provider.dart';
import 'package:htql_app/presentation/router/app_router.dart';
import 'package:htql_app/presentation/shared/app_avatar.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:htql_app/presentation/utils/employee_display.dart';
import 'package:provider/provider.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final employee = authProvider.currentUser?.employee;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Setting',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsBoldBlack20.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 14),
          _AccountCard(
            name: EmployeeDisplay.value(employee?.name),
            position: EmployeeDisplay.value(employee?.position?.name),
            avatarFileName: employee?.avatar,
          ),
          SizedBox(height: 14),
          _SettingSection(
            title: 'Hiển thị',
            children: [
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return _SwitchTile(
                    icon: themeProvider.isDarkMode
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    title: 'Dark mode',
                    subtitle: 'Đổi giao diện sáng/tối',
                    value: themeProvider.isDarkMode,
                    onChanged: (_) => themeProvider.toggleDarkMode(),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 14),
          _SettingSection(
            title: 'Thời tiết',
            children: [
              Consumer<WeatherReminderProvider>(
                builder: (context, weatherProvider, child) {
                  return _SwitchTile(
                    icon: Icons.cloud_outlined,
                    title: 'Nhắc mưa sáng mai',
                    subtitle: weatherProvider.isLoading
                        ? 'Đang kiểm tra quyền...'
                        : 'Tự nhắc sau khi app cập nhật dự báo',
                    value: weatherProvider.isEnabled,
                    onChanged: weatherProvider.isLoading
                        ? null
                        : (value) async {
                            await weatherProvider.setEnabled(value);
                            if (!context.mounted) return;

                            final message = weatherProvider.errorMessage;
                            if (message != null) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                              return;
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  value
                                      ? 'Đã bật nhắc thời tiết.'
                                      : 'Đã tắt nhắc thời tiết.',
                                ),
                              ),
                            );
                          },
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 14),
          _SettingSection(
            title: 'Tài khoản',
            children: [
              _SettingTile(
                icon: Icons.person_outline,
                title: 'Trang cá nhân',
                subtitle: 'Xem thông tin nhân viên',
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.personalScreen);
                },
              ),
              _SettingTile(
                icon: Icons.lock_outline,
                title: 'Đổi mật khẩu',
                subtitle: 'Cập nhật mật khẩu đăng nhập',
                onTap: () {
                  Navigator.pushNamed(context, AppRouter.changePasswordScreen);
                },
              ),
            ],
          ),
          SizedBox(height: 14),
          _SettingSection(
            title: 'Ứng dụng',
            children: [
              _SettingTile(
                icon: Icons.info_outline,
                title: 'Phiên bản',
                subtitle: '1.0.0',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 14),
          _LogoutTile(
            onTap: () async {
              await context.read<AuthProvider>().logout();
              if (!context.mounted) return;

              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRouter.loginScreen,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.name,
    required this.position,
    required this.avatarFileName,
  });

  final String name;
  final String position;
  final String? avatarFileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Row(
        children: [
          AppAvatar(size: 54, avatarFileName: avatarFileName),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: name,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                AppText(
                  text: position,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsMediumGrey14.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  const _SettingSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
          ),
          SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            _SettingIcon(icon: icon),
            SizedBox(width: 12),
            Expanded(
              child: _SettingText(title: title, subtitle: subtitle),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColor.secondaryTextColor(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SettingIcon(icon: icon),
        SizedBox(width: 12),
        Expanded(
          child: _SettingText(title: title, subtitle: subtitle),
        ),
        Switch(
          value: value,
          activeColor: AppColor.toyotaRed,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _LogoutTile extends StatelessWidget {
  const _LogoutTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          children: [
            _SettingIcon(icon: Icons.logout_rounded, color: AppColor.toyotaRed),
            SizedBox(width: 12),
            Expanded(
              child: AppText(
                text: 'Đăng xuất',
                textAlign: TextAlign.left,
                style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                  color: AppColor.toyotaRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingIcon extends StatelessWidget {
  const _SettingIcon({required this.icon, this.color});

  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color ?? AppColor.toyotaRed, size: 20),
    );
  }
}

class _SettingText extends StatelessWidget {
  const _SettingText({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          textAlign: TextAlign.left,
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        AppText(
          text: subtitle,
          textAlign: TextAlign.left,
          style: AppTextstyle.tsRegularGrey12.copyWith(
            color: AppColor.secondaryTextColor(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

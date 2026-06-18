import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class ChangePasswordBody extends StatefulWidget {
  const ChangePasswordBody({super.key});

  @override
  State<ChangePasswordBody> createState() => _ChangePasswordBodyState();
}

class _ChangePasswordBodyState extends State<ChangePasswordBody> {
  bool _hideCurrentPassword = true;
  bool _hideNewPassword = true;
  bool _hideConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Đổi mật khẩu',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsBoldBlack20.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 14),
          _SecurityInfoCard(),
          SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.cardColor(context),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor.borderColor(context)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(title: 'Thông tin mật khẩu'),
                SizedBox(height: 14),
                _PasswordField(
                  label: 'Mật khẩu hiện tại',
                  hintText: 'Nhập mật khẩu hiện tại',
                  obscureText: _hideCurrentPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _hideCurrentPassword = !_hideCurrentPassword;
                    });
                  },
                ),
                SizedBox(height: 12),
                _PasswordField(
                  label: 'Mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới',
                  obscureText: _hideNewPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _hideNewPassword = !_hideNewPassword;
                    });
                  },
                ),
                SizedBox(height: 12),
                _PasswordField(
                  label: 'Nhập lại mật khẩu mới',
                  hintText: 'Nhập lại mật khẩu mới',
                  obscureText: _hideConfirmPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _hideConfirmPassword = !_hideConfirmPassword;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          AppButton(
            text: 'Cập nhật mật khẩu',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Chức năng đổi mật khẩu sẽ được xử lý sau'),
                  backgroundColor: AppColor.toyotaRed,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SecurityInfoCard extends StatelessWidget {
  const _SecurityInfoCard();

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
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.lock_outline,
              color: AppColor.toyotaRed,
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Bảo mật tài khoản',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                ),
                SizedBox(height: 5),
                AppText(
                  text:
                      'Sử dụng mật khẩu đủ mạnh và không chia sẻ cho người khác.',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsMediumGrey14.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                  maxLines: 2,
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 4, height: 22, color: AppColor.toyotaRed),
        SizedBox(width: 8),
        AppText(
          text: title,
          textAlign: TextAlign.left,
          style: AppTextstyle.tsSemiBoldBlack16.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.hintText,
    required this.obscureText,
    required this.onToggleVisibility,
  });

  final String label;
  final String hintText;
  final bool obscureText;
  final VoidCallback onToggleVisibility;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(Icons.lock_outline, color: AppColor.toyotaRed),
        suffixIcon: IconButton(
          onPressed: onToggleVisibility,
          icon: Icon(
            obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: AppColor.secondaryTextColor(context),
          ),
        ),
        labelStyle: AppTextstyle.tsRegularGrey12.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        filled: true,
        fillColor: AppColor.mutedCardColor(context),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.borderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.toyotaRed),
        ),
      ),
    );
  }
}

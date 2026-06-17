import 'package:flutter/material.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class DocsSearchField extends StatelessWidget {
  const DocsSearchField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
      decoration: InputDecoration(
        hintText: 'Tìm kiếm tài liệu',
        hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        prefixIcon: Icon(Icons.search_rounded, color: AppColor.toyotaRed),
        filled: true,
        fillColor: AppColor.mutedCardColor(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
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

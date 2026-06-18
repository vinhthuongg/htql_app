import 'dart:io';

import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/feedback_provider.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FeedbackBody extends StatefulWidget {
  const FeedbackBody({super.key});

  @override
  State<FeedbackBody> createState() => _FeedbackBodyState();
}

class _FeedbackBodyState extends State<FeedbackBody> {
  final List<String> _feedbackTypes = const [
    'Góp ý chung',
    'Quy trình làm việc',
    'Cơ sở vật chất',
    'Ứng dụng nội bộ',
  ];

  String _selectedType = 'Góp ý chung';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Góp ý',
            textAlign: TextAlign.left,
            style: AppTextstyle.tsBoldBlack20.copyWith(
              color: AppColor.primaryTextColor(context),
            ),
          ),
          SizedBox(height: 14),
          _IntroCard(),
          SizedBox(height: 14),
          _FeedbackFormCard(
            feedbackTypes: _feedbackTypes,
            selectedType: _selectedType,
            onTypeChanged: (value) {
              setState(() {
                _selectedType = value;
              });
            },
          ),
          SizedBox(height: 16),
          AppButton(
            text: 'Gửi góp ý',
            onTap: () {
              context.read<FeedbackProvider>().clearImages();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Góp ý đã được ghi nhận'),
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

class _IntroCard extends StatelessWidget {
  const _IntroCard();

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
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.feedback_outlined,
              color: AppColor.toyotaRed,
              size: 22,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Đóng góp ý kiến',
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                ),
                SizedBox(height: 5),
                AppText(
                  text: 'Chia sẻ vấn đề hoặc đề xuất để cải thiện công việc.',
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

class _FeedbackFormCard extends StatelessWidget {
  const _FeedbackFormCard({
    required this.feedbackTypes,
    required this.selectedType,
    required this.onTypeChanged,
  });

  final List<String> feedbackTypes;
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldLabel(text: 'Loại góp ý'),
          SizedBox(height: 8),
          _FeedbackTypeDropdown(
            items: feedbackTypes,
            value: selectedType,
            onChanged: onTypeChanged,
          ),
          SizedBox(height: 14),
          _FieldLabel(text: 'Tiêu đề'),
          SizedBox(height: 8),
          _InputField(hintText: 'Nhập tiêu đề góp ý'),
          SizedBox(height: 14),
          _FieldLabel(text: 'Nội dung'),
          SizedBox(height: 8),
          _InputField(hintText: 'Nhập nội dung góp ý', maxLines: 5),
          SizedBox(height: 14),
          _FieldLabel(text: 'Hình ảnh đính kèm'),
          SizedBox(height: 8),
          _ImagePickerSection(),
        ],
      ),
    );
  }
}

class _ImagePickerSection extends StatelessWidget {
  const _ImagePickerSection();

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedbackProvider>(
      builder: (context, feedbackProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: feedbackProvider.pickImages,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.mutedCardColor(context),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.borderColor(context)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColor.cardColor(context),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColor.toyotaRed,
                        size: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Tải ảnh lên',
                            textAlign: TextAlign.left,
                            style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                              color: AppColor.primaryTextColor(context),
                            ),
                          ),
                          SizedBox(height: 3),
                          AppText(
                            text: 'Có thể chọn nhiều ảnh cùng lúc',
                            textAlign: TextAlign.left,
                            style: AppTextstyle.tsRegularGrey12.copyWith(
                              color: AppColor.secondaryTextColor(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (feedbackProvider.hasImages) ...[
              SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: feedbackProvider.images
                    .map(
                      (image) => _ImagePreview(
                        image: image,
                        onRemove: () {
                          feedbackProvider.removeImage(image);
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.image, required this.onRemove});

  final XFile image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            color: AppColor.mutedCardColor(context),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.borderColor(context)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(File(image.path), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -7,
          right: -7,
          child: InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColor.toyotaRed,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.cardColor(context)),
              ),
              child: Icon(Icons.close_rounded, color: AppColor.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeedbackTypeDropdown extends StatelessWidget {
  const _FeedbackTypeDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<String> items;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColor.cardColor(context),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.secondaryTextColor(context),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: AppText(
                    text: item,
                    textAlign: TextAlign.left,
                    style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                      color: AppColor.primaryTextColor(context),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            onChanged(value);
          },
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({required this.hintText, this.maxLines = 1});

  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
        filled: true,
        fillColor: AppColor.mutedCardColor(context),
        contentPadding: const EdgeInsets.all(12),
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppText(
      text: text,
      textAlign: TextAlign.left,
      style: AppTextstyle.tsSemiBoldBlack14.copyWith(
        color: AppColor.primaryTextColor(context),
      ),
    );
  }
}

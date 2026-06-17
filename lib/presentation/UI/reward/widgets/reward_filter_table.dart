import 'package:flutter/material.dart';
import 'package:htql_app/presentation/provider/reward_provider.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';

class RewardFilterTable extends StatelessWidget {
  const RewardFilterTable({super.key, required this.rewardProvider});

  final RewardProvider rewardProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: rewardProvider.searchKeyword,
          onChanged: rewardProvider.setSearchKeyword,
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: AppColor.primaryTextColor(context),
          ),
          decoration: InputDecoration(
            hintText: rewardProvider.searchHint,
            hintStyle: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
            prefixIcon: Icon(Icons.search_rounded, color: AppColor.toyotaRed),
            filled: true,
            fillColor: AppColor.cardColor(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColor.borderColor(context)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColor.toyotaRed),
            ),
          ),
        ),
        SizedBox(height: 14),
        if (rewardProvider.isGiftTab)
          _GiftList(rewardProvider: rewardProvider)
        else
          _RecordList(rewardProvider: rewardProvider),
      ],
    );
  }
}

class _RecordList extends StatelessWidget {
  const _RecordList({required this.rewardProvider});

  final RewardProvider rewardProvider;

  @override
  Widget build(BuildContext context) {
    final records = rewardProvider.filteredRecords;

    if (records.isEmpty) {
      return _EmptyState(message: rewardProvider.emptyMessage);
    }

    return Column(
      children: List.generate(
        records.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: index == records.length - 1 ? 0 : 10,
          ),
          child: _RewardRecordCard(index: index + 1, record: records[index]),
        ),
      ),
    );
  }
}

class _GiftList extends StatelessWidget {
  const _GiftList({required this.rewardProvider});

  final RewardProvider rewardProvider;

  @override
  Widget build(BuildContext context) {
    final gifts = rewardProvider.filteredGifts;

    if (gifts.isEmpty) {
      return _EmptyState(message: rewardProvider.emptyMessage);
    }

    return Column(
      children: List.generate(
        gifts.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: index == gifts.length - 1 ? 0 : 10),
          child: _GiftCard(gift: gifts[index]),
        ),
      ),
    );
  }
}

class _RewardRecordCard extends StatelessWidget {
  const _RewardRecordCard({required this.index, required this.record});

  final int index;
  final RewardRecord record;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.mutedCardColor(context),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: AppText(
                  text: index.toString(),
                  style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AppText(
                  text: record.type,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _PointBadge(points: record.points),
            ],
          ),
          SizedBox(height: 12),
          AppText(
            text: record.content,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetaItem(icon: Icons.event_rounded, text: record.date),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _MetaItem(icon: Icons.notes_rounded, text: record.note),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GiftCard extends StatelessWidget {
  const _GiftCard({required this.gift});

  final RewardGift gift;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard_rounded,
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
                  text: gift.name,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                    color: AppColor.primaryTextColor(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                AppText(
                  text: gift.description,
                  textAlign: TextAlign.left,
                  style: AppTextstyle.tsMediumGrey14.copyWith(
                    color: AppColor.secondaryTextColor(context),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    _PointBadge(points: gift.points),
                    SizedBox(width: 10),
                    Expanded(
                      child: AppText(
                        text: 'Còn ${gift.stock}',
                        textAlign: TextAlign.left,
                        style: AppTextstyle.tsMediumGrey14.copyWith(
                          color: AppColor.secondaryTextColor(context),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: AppColor.toyotaRed,
                        foregroundColor: AppColor.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: AppText(
                        text: 'Đổi',
                        style: AppTextstyle.tsSemiBoldBlack14.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PointBadge extends StatelessWidget {
  const _PointBadge({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.toyotaRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: AppText(
        text: '$points điểm',
        style: AppTextstyle.tsSemiBoldBlack14.copyWith(
          color: AppColor.toyotaRed,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColor.secondaryTextColor(context)),
        SizedBox(width: 6),
        Expanded(
          child: AppText(
            text: text,
            textAlign: TextAlign.left,
            style: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: AppText(
        text: message,
        style: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
      ),
    );
  }
}

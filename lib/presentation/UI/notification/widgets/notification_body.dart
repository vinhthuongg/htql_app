import 'package:flutter/material.dart';
import 'package:htql_app/data/models/notification/notification_response.dart';
import 'package:htql_app/presentation/provider/notification_provider.dart';
import 'package:htql_app/presentation/shared/app_button.dart';
import 'package:htql_app/presentation/shared/app_text.dart';
import 'package:htql_app/presentation/shared/app_textstyle.dart';
import 'package:htql_app/presentation/theme/app_color.dart';
import 'package:provider/provider.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, notificationProvider, child) {
        final notifications = notificationProvider.filteredNotifications;

        return RefreshIndicator(
          color: AppColor.toyotaRed,
          onRefresh: () {
            return notificationProvider.fetchNotifications(forceRefresh: true);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text: 'Thông báo',
                        textAlign: TextAlign.left,
                        style: AppTextstyle.tsBoldBlack20.copyWith(
                          color: AppColor.primaryTextColor(context),
                        ),
                      ),
                    ),
                    _UnreadBadge(count: notificationProvider.unreadCount),
                  ],
                ),
                SizedBox(height: 14),
                _FilterBar(
                  unreadCount: notificationProvider.unreadCount,
                  selectedFilter: notificationProvider.selectedFilter,
                  onFilterChanged: notificationProvider.setFilter,
                ),
                SizedBox(height: 14),
                if (notificationProvider.isLoading &&
                    !notificationProvider.hasLoaded)
                  _LoadingCard()
                else if (notificationProvider.errorMessage != null)
                  _ErrorCard(
                    message: notificationProvider.errorMessage!,
                    onRetry: () {
                      notificationProvider.fetchNotifications(
                        forceRefresh: true,
                      );
                    },
                  )
                else if (notifications.isEmpty)
                  _EmptyNotificationCard(
                    message:
                        notificationProvider.selectedFilter ==
                            NotificationFilter.unread
                        ? 'Không có thông báo chưa đọc'
                        : 'Chưa có thông báo',
                  )
                else
                  ...notifications.map(
                    (notification) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _NotificationCard(notification: notification),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.unreadCount,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final int unreadCount;
  final NotificationFilter selectedFilter;
  final ValueChanged<NotificationFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _FilterButton(
              text: 'Tất cả',
              isSelected: selectedFilter == NotificationFilter.all,
              onTap: () => onFilterChanged(NotificationFilter.all),
            ),
          ),
          SizedBox(width: 6),
          Expanded(
            child: _FilterButton(
              text: 'Chưa đọc ($unreadCount)',
              isSelected: selectedFilter == NotificationFilter.unread,
              onTap: () => onFilterChanged(NotificationFilter.unread),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.text,
    required this.onTap,
    this.isSelected = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.toyotaRed
              : AppColor.mutedCardColor(context),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AppText(
          text: text,
          style: AppTextstyle.tsSemiBoldBlack14.copyWith(
            color: isSelected
                ? AppColor.white
                : AppColor.primaryTextColor(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.notification});

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: notification.isUnread
              ? AppColor.toyotaRed
              : AppColor.borderColor(context),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColor.mutedCardColor(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _notificationIcon(notification),
              color: AppColor.toyotaRed,
              size: 21,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text: notification.message ?? 'Thông báo mới',
                        textAlign: TextAlign.left,
                        style: AppTextstyle.tsSemiBoldBlack16.copyWith(
                          color: AppColor.primaryTextColor(context),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (notification.isUnread) ...[
                      SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColor.toyotaRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    _TypeBadge(text: notification.displayType),
                    Spacer(),
                    AppText(
                      text: notification.createdAtFormatted ?? '',
                      style: AppTextstyle.tsRegularGrey12.copyWith(
                        color: AppColor.secondaryTextColor(context),
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

  IconData _notificationIcon(NotificationItem notification) {
    switch (notification.type) {
      case '1':
        return Icons.event_note_outlined;
      case '2':
        return Icons.access_time_outlined;
      case '3':
        return Icons.payments_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColor.toyotaRed,
        borderRadius: BorderRadius.circular(6),
      ),
      child: AppText(
        text: '$count mới',
        style: AppTextstyle.tsSemiBoldBlack14.copyWith(color: AppColor.white),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.mutedCardColor(context),
        borderRadius: BorderRadius.circular(6),
      ),
      child: AppText(text: text, style: AppTextstyle.tsMediumRed12),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: Center(
        child: CircularProgressIndicator(color: AppColor.toyotaRed),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

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
        children: [
          AppText(
            text: message,
            style: AppTextstyle.tsMediumGrey14.copyWith(
              color: AppColor.secondaryTextColor(context),
            ),
          ),
          SizedBox(height: 12),
          AppButton(text: 'Tải lại', onTap: onRetry),
        ],
      ),
    );
  }
}

class _EmptyNotificationCard extends StatelessWidget {
  const _EmptyNotificationCard({required this.message});

  final String message;

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
      child: AppText(
        text: message,
        style: AppTextstyle.tsMediumGrey14.copyWith(
          color: AppColor.secondaryTextColor(context),
        ),
      ),
    );
  }
}

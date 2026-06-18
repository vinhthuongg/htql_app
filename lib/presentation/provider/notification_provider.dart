import 'package:flutter/material.dart';
import 'package:htql_app/data/models/notification/notification_response.dart';
import 'package:htql_app/repositories/notification_repository.dart';

enum NotificationFilter { all, unread }

class NotificationProvider extends ChangeNotifier {
  NotificationProvider({NotificationRepository? notificationRepository})
    : _notificationRepository =
          notificationRepository ?? NotificationRepository();

  final NotificationRepository _notificationRepository;

  bool _isLoading = false;
  bool _hasLoaded = false;
  String? _errorMessage;
  List<NotificationItem> _notifications = [];
  NotificationFilter _selectedFilter = NotificationFilter.all;
  int _unreadCount = 0;
  int _unsoundedCount = 0;

  bool get isLoading => _isLoading;
  bool get hasLoaded => _hasLoaded;
  String? get errorMessage => _errorMessage;
  List<NotificationItem> get notifications =>
      List<NotificationItem>.unmodifiable(_notifications);
  NotificationFilter get selectedFilter => _selectedFilter;
  List<NotificationItem> get filteredNotifications {
    if (_selectedFilter == NotificationFilter.unread) {
      return _notifications
          .where((notification) => notification.isUnread)
          .toList();
    }

    return notifications;
  }

  int get unreadCount => _unreadCount;
  int get unsoundedCount => _unsoundedCount;

  void setFilter(NotificationFilter filter) {
    if (_selectedFilter == filter) return;

    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> fetchNotifications({bool forceRefresh = false}) async {
    if (_isLoading) return;
    if (_hasLoaded && !forceRefresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _notificationRepository.getNotifications();
      _notifications = data.notifications;
      _unreadCount = data.unreadCount;
      _unsoundedCount = data.unsoundedCount;
      _hasLoaded = true;
    } on NotificationException catch (error) {
      _errorMessage = error.message;
    } catch (_) {
      _errorMessage = 'Không thể tải thông báo, vui lòng thử lại';
    }

    _isLoading = false;
    notifyListeners();
  }
}

import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  const NotificationResponse({
    required this.status,
    required this.data,
    this.message,
  });

  final bool status;
  final NotificationData data;
  final String? message;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationData {
  const NotificationData({
    this.notifications = const [],
    this.unreadCount = 0,
    this.unsoundedCount = 0,
  });

  final List<NotificationItem> notifications;

  @JsonKey(name: 'unread_count')
  final int unreadCount;

  @JsonKey(name: 'unsounded_count')
  final int unsoundedCount;

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

@JsonSerializable()
class NotificationItem {
  const NotificationItem({
    required this.id,
    this.idEmployee,
    this.type,
    this.message,
    this.url,
    this.status,
    this.seenTime,
    this.sound,
    this.createdAt,
    this.updatedAt,
    this.idRef,
    this.createdAtFormatted,
    this.fullUrl,
  });

  final String id;

  @JsonKey(name: 'id_employee')
  final String? idEmployee;

  final String? type;
  final String? message;
  final String? url;
  final String? status;

  @JsonKey(name: 'seen_time')
  final String? seenTime;

  final String? sound;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'id_ref')
  final String? idRef;

  @JsonKey(name: 'created_at_formatted')
  final String? createdAtFormatted;

  @JsonKey(name: 'full_url')
  final String? fullUrl;

  bool get isUnread => status != '1';

  String get displayType {
    switch (type) {
      case '1':
        return 'Nghỉ phép';
      case '2':
        return 'Chấm công';
      case '3':
        return 'Lương';
      default:
        return 'Thông báo';
    }
  }

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemToJson(this);
}

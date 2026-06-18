// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
  Map<String, dynamic> json,
) => NotificationResponse(
  status: json['status'] as bool,
  data: NotificationData.fromJson(json['data'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$NotificationResponseToJson(
  NotificationResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.data,
  'message': instance.message,
};

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      notifications:
          (json['notifications'] as List<dynamic>?)
              ?.map((e) => NotificationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      unsoundedCount: (json['unsounded_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'unread_count': instance.unreadCount,
      'unsounded_count': instance.unsoundedCount,
    };

NotificationItem _$NotificationItemFromJson(Map<String, dynamic> json) =>
    NotificationItem(
      id: json['id'] as String,
      idEmployee: json['id_employee'] as String?,
      type: json['type'] as String?,
      message: json['message'] as String?,
      url: json['url'] as String?,
      status: json['status'] as String?,
      seenTime: json['seen_time'] as String?,
      sound: json['sound'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      idRef: json['id_ref'] as String?,
      createdAtFormatted: json['created_at_formatted'] as String?,
      fullUrl: json['full_url'] as String?,
    );

Map<String, dynamic> _$NotificationItemToJson(NotificationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_employee': instance.idEmployee,
      'type': instance.type,
      'message': instance.message,
      'url': instance.url,
      'status': instance.status,
      'seen_time': instance.seenTime,
      'sound': instance.sound,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'id_ref': instance.idRef,
      'created_at_formatted': instance.createdAtFormatted,
      'full_url': instance.fullUrl,
    };

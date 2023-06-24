// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyNotification _$MyNotificationFromJson(Map<String, dynamic> json) =>
    MyNotification(
      message: json['message'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );

Map<String, dynamic> _$MyNotificationToJson(MyNotification instance) =>
    <String, dynamic>{
      'message': instance.message,
      'hour': instance.hour,
      'minute': instance.minute,
    };

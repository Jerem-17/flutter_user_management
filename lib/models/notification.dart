
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class MyNotification {
  String message;
  int hour;
  int minute;

  MyNotification(
      {
        required this.message,
        required this.hour,
        required this.minute,
      });

  factory MyNotification.fromJsons(Map<String, dynamic>json)=>MyNotification(message: json['message'],hour: json['hour'],minute: json['minute']);

  Map<String, dynamic> toJsons() => {
    'message': message,
    'hour': hour,
    'minute': minute,
  };

  factory MyNotification.fromJson(Map<String, dynamic> json) => _$MyNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$MyNotificationToJson(this);
}
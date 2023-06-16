import 'package:usermanagement/models/user.dart';

class MyNotification {
  var id;
  int? user_id;
  String username;
  String message;
  int hour;
  int minute;

  MyNotification(
      {
        required this.username,
        required this.message,
        required this.hour,
        required this.minute,
      });

  factory MyNotification.fromJson(Map<String, dynamic>json)=>MyNotification(username: json['username'], message: json['message'],hour: json['hour'],minute: json['minute']);

  Map<String, dynamic> toJson() => {
    'username': username,
    'message': message,
    'hour': hour,
    'minute': minute,
  };
}
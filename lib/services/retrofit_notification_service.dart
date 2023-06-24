import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:usermanagement/models/notification.dart';



part 'retrofit_notification_service.g.dart';

// use ngrok to generate your api url and use it here
/*
ngrok http <port>. Example: ngrok http 3000
 */
@RestApi(baseUrl: 'https://a44c-2c0f-f0f8-21c-6b00-a737-d297-8ac0-58bc.eu.ngrok.io/api')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/notifications')
  Future<List<MyNotification>> getNotifications();

}

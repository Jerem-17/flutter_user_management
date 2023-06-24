import 'package:dio/dio.dart';

class IsApiReachable {
  static bool useLocalDatabase = false;

  static Future<bool> checkIfApiReachable() async {
    try {
      const url = 'https://a44c-2c0f-f0f8-21c-6b00-a737-d297-8ac0-58bc.eu.ngrok.io/api';
      final response = await Dio().get(url);

      return response.statusCode == 200 ? true : false;
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }
}
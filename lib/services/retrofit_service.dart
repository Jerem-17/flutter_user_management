import 'dart:ffi';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';
// import 'user.dart';


part 'retrofit_service.g.dart';

// use ngrok to generate your api url and use it here
/*
ngrok http <port>. Example: ngrok http 3000
 */
@RestApi(baseUrl: 'https://a44c-2c0f-f0f8-21c-6b00-a737-d297-8ac0-58bc.eu.ngrok.io/api')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{firstname}&{lastname}&{age}')
  Future<int> getUserId(String firstname, String lastname, int age);

  @POST('/users')
  Future<User> createUser(@Body() User user);

  @PUT('/users/{id}')
  Future<User> updateUser(@Path('id') id, @Body() User updatedUser);

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') id);
}

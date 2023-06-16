import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../models/user.dart';
// import 'user.dart';


part 'retrofit_service.g.dart';

@RestApi(baseUrl: 'https://api.example.com')
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/users')
  Future<List<User>> getUsers();

  @POST('/users')
  Future<User> createUser(@Body() User user);

  @PUT('/users/{id}')
  Future<User> updateUser(@Path('id') int id, @Body() User updatedUser);

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') int id);
}

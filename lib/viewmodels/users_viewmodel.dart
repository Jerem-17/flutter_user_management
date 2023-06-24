import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usermanagement/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

import './providers/usermodelproviders.dart';

class UserViewModel extends ChangeNotifier {

  final _users = <User>[].obs;

  List<User> get users => _users;

  Future<List<User>> fetchUsers() async {
    final fetchedUsers = await UserDatabaseHelper.getAllUsers();
    if (fetchedUsers != null) {
      _users.value = fetchedUsers;
      return fetchedUsers;
    } else {
      throw Exception('Failed to fetch users');
    }
  }



  Future<void> createUser(User user) async {

    await UserDatabaseHelper.createUser(user);

    _users.add(user);

    notifyListeners();
  }

}
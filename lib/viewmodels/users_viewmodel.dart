import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usermanagement/services/db_user_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user.dart';

import './providers/usermodelproviders.dart';

class UserViewModel extends ChangeNotifier {

  final _users = <User>[].obs;

  List<User> get users => _users;

  void fetchUsers() async {
    final fetchedUsers = await UserDatabaseHelper.getAllUsers();
    _users.value = fetchedUsers!;
  }
}
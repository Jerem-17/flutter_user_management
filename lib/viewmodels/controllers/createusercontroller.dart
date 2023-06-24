import 'package:usermanagement/models/user.dart';

import '../users_viewmodel.dart';

class CreateUserControllerProvider{
  final UserViewModel _userViewModel;

  CreateUserControllerProvider(this._userViewModel);

  Future<void> addUser(User user) async {
    await _userViewModel.createUser(user);
  }
}
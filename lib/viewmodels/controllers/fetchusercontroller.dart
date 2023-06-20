


import '../users_viewmodel.dart';

class UserController {
  final UserViewModel _viewModel;

  UserController(this._viewModel);

  Future<void> fetchUsers() async {
    _viewModel.fetchUsers();
  }
}
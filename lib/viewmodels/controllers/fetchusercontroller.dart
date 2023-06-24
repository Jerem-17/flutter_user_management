import '../users_viewmodel.dart';

class FetchUserController {
  final UserViewModel _viewModel;

  FetchUserController(this._viewModel);

  Future<void> fetchUsers() async {
    _viewModel.fetchUsers();
  }
}
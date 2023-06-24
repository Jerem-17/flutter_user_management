import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/createusercontroller.dart';
import '../controllers/fetchusercontroller.dart';
import '../users_viewmodel.dart';

final userViewModelProvider = Provider<UserViewModel>((ref) => UserViewModel());
final fetchUserControllerProvider = Provider<FetchUserController>((ref) {
  final viewModel = ref.watch(userViewModelProvider);
  return FetchUserController(viewModel);
});
final createUserControllerProvider = Provider.autoDispose<CreateUserControllerProvider>((ref) {
  final viewModel = ref.watch(userViewModelProvider);
  return CreateUserControllerProvider(viewModel);
});
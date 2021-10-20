import 'package:cts/constants/globals.dart';
import 'package:cts/data/controllers/login_controller.dart';
import 'package:cts/data/models/LoginModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginDataState = FutureProvider<LoginModel>((ref) async {
  return LoginController().userLogin(
      Globals.userNameController.text, Globals.passwordController.text);
});

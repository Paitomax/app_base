import 'package:app_base/src/shared/user/user_model.dart';

abstract class SignInRepositoryInterface {
  Future<UserModel> requestLogin(String user, String password);
}

import 'package:app_base/src/shared/current_datetime/current_date.dart';
import 'package:app_base/src/shared/user/user_model.dart';

class Mocks {
  static UserModel userModel() =>
      UserModel(name: 'José', id: 1, email: 'jose@boticario.com.br');
}

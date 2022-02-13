import 'package:asteroid_test/src/core/auth/auth.dart';
import 'package:asteroid_test/src/core/providers/base_model.dart';

class LoginViewModel extends BaseModel {
  String _email = '';

  String get email => _email;

  set setEmail(String value) {
    _email = value;

    notifyListeners();
  }

  String _password = '';

  String get password => _password;

  set setPassword(String value) {
    _password = value;

    notifyListeners();
  }

  Future<bool> login() async {
    setState(ViewState.Busy);

    final resp = await authService.signIn(email, password);

    setState(ViewState.Idle);

    return resp;
  }
}

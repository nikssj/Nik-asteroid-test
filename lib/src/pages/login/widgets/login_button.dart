import 'package:flutter/material.dart';
import 'package:asteroid_test/src/core/providers/base_model.dart';
import 'package:asteroid_test/src/pages/home/home_page.dart';
import 'package:asteroid_test/src/pages/login/login_view_model.dart';
import 'package:asteroid_test/src/widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginVm = Provider.of<LoginViewModel>(context, listen: true);

    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: loginVm.state == ViewState.Busy
              ? SizedBox(
                  child: CircularProgressIndicator(),
                  width: 20,
                  height: 20,
                )
              : Text('Login'),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 0.0,
        color: loginVm.email.isEmpty || loginVm.password.isEmpty
            ? Colors.grey
            : Colors.deepPurple,
        textColor: Colors.white,
        onPressed: () async {
          FocusScope.of(context).unfocus();
          await _login(context);
        });
  }

  _login(BuildContext context) async {
    final loginVm = Provider.of<LoginViewModel>(context, listen: false);

    final resp = await loginVm.login();

    if (!resp) {
      toastService.showToast("Usuario y/o contraseña incorrectos.");

      return;
    }

    if (resp) {
      Get.offAll(() => HomePage());

      toastService.showToast("Inicio de sesión correcto!");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:asteroid_test/src/pages/login/widgets/background_stack.dart';

import 'package:asteroid_test/src/pages/login/widgets/email_input.dart';
import 'package:asteroid_test/src/pages/login/widgets/login_button.dart';
import 'package:asteroid_test/src/pages/login/widgets/password_input.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: EdgeInsets.only(bottom: bottom),
              child: Stack(
                children: <Widget>[
                  _crearFondo(context),
                  _loginForm(context),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        SafeArea(
          child: Container(height: size.height * 0.3),
        ),
        Container(
          width: size.width * 0.85,
          margin: EdgeInsets.symmetric(vertical: size.height * 0.025),
          padding: EdgeInsets.symmetric(vertical: size.height * 0.04),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0)
              ]),
          child: Column(
            children: <Widget>[
              Text('Login', style: TextStyle(fontSize: size.width * 0.05)),
              SizedBox(height: size.height * 0.03),
              _crearEmail(),
              SizedBox(height: size.height * 0.03),
              _crearPassword(),
              SizedBox(height: size.height * 0.03),
              _crearBoton()
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.025,
        ),
        Text(
          '¿Olvido la contraseña?',
          style: TextStyle(fontSize: size.width * 0.0425),
        ),
      ],
    );
  }

  Widget _crearEmail() {
    return EmailInput();
  }

  Widget _crearPassword() {
    return PasswordInput();
  }

  Widget _crearBoton() {
    return LoginButton();
  }

  Widget _crearFondo(BuildContext context) {
    return BackgroundStack();
  }
}

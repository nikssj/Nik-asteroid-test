import 'package:flutter/material.dart';
import 'package:asteroid_test/src/pages/login/login_view_model.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginVm = Provider.of<LoginViewModel>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
          labelText: 'Contraseña',
        ),
        onChanged: (value) => loginVm.setPassword = value,
      ),
    );
  }
}

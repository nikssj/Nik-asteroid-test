import 'package:flutter/material.dart';
import 'package:asteroid_test/src/pages/login/login_view_model.dart';
import 'package:provider/provider.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginVm = Provider.of<LoginViewModel>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico',
        ),
        onChanged: (value) => loginVm.setEmail = value,
      ),
    );
  }
}

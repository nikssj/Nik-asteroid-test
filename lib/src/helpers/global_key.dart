import 'package:flutter/material.dart';

//Global context for custom_loading.dart widget
MyGlobals myGlobals = new MyGlobals();

class MyGlobals {
  var _snackBarContext;

  get snackBarContext => _snackBarContext;

  set setSnackBarContext(BuildContext context) {
    _snackBarContext = context;
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final toastService = new ToastService();

//Toast para mensajes
class ToastService {
  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        webPosition: 'center',
        fontSize: 16.0);
  }
}

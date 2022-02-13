import 'package:flutter/material.dart';

//Custom Footer Bar.
//Utilizado comunmente para insertar un Button al final del scaffold

class CustomFooterBar extends StatelessWidget {
  final Widget widget;

  CustomFooterBar({this.widget});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                  top: _size.height * 0.07, bottom: _size.height * 0.04),
              child: Align(alignment: Alignment.bottomCenter, child: widget),
            )),
          ],
        ),
      ],
    );
  }
}

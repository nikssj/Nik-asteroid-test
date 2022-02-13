import 'package:flutter/material.dart';

//Responsive Body. Acomoda los widgets para todo tipos de resoluciones.
//Utilizado en caso de poner en una sola View muchos widgets verticalmente
//Con esto se evita el overflow

class ResponsiveBody extends StatelessWidget {
  final Widget child;

  final double width;

  ResponsiveBody({this.child, this.width});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: size.width * (width ?? 1),
                minWidth: size.width * (width ?? 1),
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(child: child),
          ),
        ),
      );
    });
  }
}

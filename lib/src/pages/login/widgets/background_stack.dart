import 'package:flutter/material.dart';

class BackgroundStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      // color: Colors.amber,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0)
      ])),
    );

    final circulo = Container(
      width: size.width * 0.2,
      height: size.width * 0.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(
            top: size.height * 0.1, left: size.width * 0.1, child: circulo),
        Positioned(
            top: size.height * 0.05, right: size.width * 0.2, child: circulo),
        Positioned(
            bottom: size.height * -0.05,
            right: size.width * 0.1,
            child: circulo),
        Positioned(
            bottom: size.height * 0.12,
            right: size.width * 0.05,
            child: circulo),
        Container(
          padding: EdgeInsets.only(top: size.height * 0.08),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.05, width: double.infinity),
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: size.height * 0.01, width: double.infinity),
              Text('Asteroid Technologies',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold))
            ],
          ),
        )
      ],
    );
  }
}

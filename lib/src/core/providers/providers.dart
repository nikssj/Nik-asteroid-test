import 'package:flutter/material.dart';
import 'package:asteroid_test/src/pages/home/home_view_model.dart';
import 'package:asteroid_test/src/pages/incidente/incidente_view_model.dart';
import 'package:asteroid_test/src/pages/login/login_view_model.dart';
import 'package:provider/provider.dart';

//Archivo Providers para controlar los widgets de la UI

class MultiProviders extends StatefulWidget {
  final Widget child;
  MultiProviders({this.child});

  @override
  _MultiProvidersState createState() => _MultiProvidersState();
}

class _MultiProvidersState extends State<MultiProviders> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(),
        ),
        ChangeNotifierProvider<IncidenteViewModel>(
          create: (_) => IncidenteViewModel(),
        ),
      ],
      child: widget.child,
    );
  }
}

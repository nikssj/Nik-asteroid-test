import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:asteroid_test/src/pages/home/home_page.dart';

import 'package:asteroid_test/src/pages/login/login_page.dart';
import 'package:asteroid_test/src/pages/incidente/incidente_page.dart';
import 'package:get/get.dart';

import 'src/core/providers/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProviders(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        navigatorKey: Get.key,
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => IncidentePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          fontFamily: 'WorkSans',
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:frontend/pages/mainPage.dart';
import 'package:frontend/pages/loginPage.dart';
import 'package:frontend/pages/profilePage.dart';
import 'package:frontend/pages/registerPage.dart';
import 'package:frontend/pages/myfavoritesPage.dart';
import 'package:frontend/pages/myapplicationsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => const MainPage(), settings: settings);
          case 'login':
            return CupertinoPageRoute(
                builder: (_) => const LoginPage(), settings: settings);
          case 'profile':
            return CupertinoPageRoute(
                builder: (_) => const ProfilePage(), settings: settings);
          case 'register':
            return CupertinoPageRoute(
                builder: (_) => const RegisterPage(), settings: settings);
          case 'myfavorites':
            return CupertinoPageRoute(
                builder: (_) => const MyFavoritesPage(), settings: settings);
          case 'myapplications':
            return CupertinoPageRoute(
                builder: (_) => const MyApplicationsPage(), settings: settings);
        }
      },
    );
  }
}
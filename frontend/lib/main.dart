import 'package:flutter/material.dart';

import 'package:frontend/pages/mainPage.dart';
import 'package:frontend/pages/loginPage.dart';
import 'package:frontend/pages/profilePage.dart';
import 'package:frontend/pages/registerPage.dart';
import 'package:frontend/pages/descriptionPage.dart';
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
      routes: {
        "/": (context) => const MainPage(),
        "login": (context) => const LoginPage(),
        "profile": (context) => const ProfilePage(),
        "register": (context) => const RegisterPage(),
        "description": (context) => const DescriptionPage(),
        "myapplications": (context) => const MyApplicationsPage(),
      },
    );
  }
}
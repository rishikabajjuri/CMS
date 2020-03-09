import 'package:complaint_managament_system/login/login_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final customColor = Colors.redAccent.withOpacity(0.8);
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Nunito_Sans',
            primaryColor: Colors.redAccent,
            accentColor: customColor,
            buttonTheme: ButtonThemeData(buttonColor: customColor),
            iconTheme: IconThemeData(
              color: customColor,
            ),
            appBarTheme: AppBarTheme(color: customColor),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: customColor,
            )),
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}

import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/admin_home_page.dart';
import 'package:complaint_managament_system/home/user_home_page.dart';
import 'package:complaint_managament_system/login/user_login_page.dart';
import 'package:complaint_managament_system/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget launchingWidget = Container();
  @override
  void initState() {
    super.initState();
    Prefs.getUID().then((value) {
      print(value);
      if(value == null)
        launchingWidget = OnBoarding();
      else
        launchingWidget = AdminHomePage();
      setState(() {

      });
    });
  }
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
        home: launchingWidget);
  }
}

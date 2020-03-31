import 'package:complaint_managament_system/login/admin_login_page.dart';
import 'package:complaint_managament_system/login/user_login_page.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  static openReplacement(context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => OnBoarding()));

  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'WELCOME TO CMS',
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            RaisedButton(
              color: Colors.white,
              onPressed: () {
                UserLoginPage.openReplacement(context);
              },
              child: Text(
                'USER',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
            RaisedButton(
              color: Colors.white,
              onPressed: () {
                AdminLoginPage.openReplacement(context);
              },
              child: Text(
                'ADMIN',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color1, color2])),
      ),
    );
  }
}

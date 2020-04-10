import 'package:complaint_managament_system/login/admin_login_page.dart';
import 'package:complaint_managament_system/login/user_login_page.dart';
import 'package:flutter/material.dart';

class OnBoarding extends StatefulWidget {
  static openReplacement(context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => OnBoarding()));

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: Image.asset(
                'assets/images/person_waving.png',
                color: Colors.white,
                height: 280,
              ),
            ),
            SizedBox(height: 40),
            Hero(
                tag: 'user_box',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      UserLoginPage.openReplacement(context);
                    },
                    child: Text(
                      'USER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: 'admin_box',
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    AdminLoginPage.openReplacement(context);
                  },
                  child: Text(
                    'ADMIN',
                    style: TextStyle(
                      fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [color1, color2])),
      ),
    );
  }
}

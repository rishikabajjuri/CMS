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
              padding: const EdgeInsets.only(top: 140),
              child: Image.asset(
                'assets/images/person_waving.png',
                color: Colors.white,
                height: 220,
              ),
            ),
            //SizedBox(height: 50),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
                child: Hero(
                  tag: 'user_box',
                  child: Material(
                    color: Colors.transparent,
                    child: RaisedButton(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      color: Colors.white,
                      onPressed: () {
                        UserLoginPage.openReplacement(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Text(
                          'USER',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor.withOpacity(0.8),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Hero(
                tag: 'admin_box',
                child: Material(
                  color: Colors.transparent,
                  child: RaisedButton(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    color: Colors.white,
                    onPressed: () {
                      AdminLoginPage.openReplacement(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        'ADMIN',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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

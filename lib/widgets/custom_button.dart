import 'package:complaint_managament_system/login/user_login_verification.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String next;
  final Function onTap;

  const CustomButton({Key key, this.next, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  color1.withOpacity(0.6),
                  color2.withOpacity(0.25)
                ])),
        child: InkWell(
          onTap:()=> onTap(),
          child: Text(
            '$next',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

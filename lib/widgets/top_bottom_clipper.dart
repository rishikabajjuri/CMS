import 'package:flutter/material.dart';

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 30);

    var firstCtrlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.55, size.height - 35);

    path.quadraticBezierTo(firstCtrlPoint.dx, firstCtrlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondCtrlPoint =
        Offset(size.width - (size.width / 3.35), size.height - 120);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondCtrlPoint.dx, secondCtrlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    var firstCtrlPoint = Offset(size.width / 4, size.height+10);
    var firstEndPoint = Offset(size.width / 2.4, size.height - 30);

    path.quadraticBezierTo(firstCtrlPoint.dx, firstCtrlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondCtrlPoint =
    Offset(size.width - (size.width / 3.35), size.height - 100);
    var secondEndPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(secondCtrlPoint.dx, secondCtrlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
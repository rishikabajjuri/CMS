import 'package:complaint_managament_system/util/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    7e0cf5
    final Color customPurple = HexColor('7e0cf5');
    final Color customPink = HexColor('f6e5f5');
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: ClipPath(
        child: Container(
          height: 300,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.deepOrange])),
        ),
        clipper: BoxClipper(),
      ),
    );
  }
}

class BoxClipper extends CustomClipper<Path> {
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

//ListView(
//children: <Widget>[
//Padding(
//padding: const EdgeInsets.only(top: 20, left: 20),
//child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Text(
//'Welcome.',
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: 30,
//),
//),
//Row(
//children: <Widget>[
//CircleAvatar(
//backgroundColor: customPurple,
//radius: 17,
//),
//Container(
//margin: EdgeInsets.only(left: 10),
//height: 90,
//width: 45,
//decoration: BoxDecoration(
//color: customPurple,
//borderRadius: BorderRadius.only(
//topLeft: Radius.circular(120),
//bottomLeft: Radius.circular(120))),
//),
//],
//)
//],
//),
//),
//SizedBox(
//height: 160,
//),
//Card(
//color: customPink,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.only(
//topLeft: Radius.circular(28),
//bottomLeft: Radius.circular(28))),
//margin: EdgeInsets.only(left: 50),
//child: Padding(
//padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
//child: Column(
//children: <Widget>[
//TextFormField(
//keyboardType: TextInputType.number,
//inputFormatters: [
//WhitelistingTextInputFormatter.digitsOnly
//],
//decoration: InputDecoration(
//prefixIcon: Icon(
//Icons.phone_android,
//size: 20,
//color: customPurple,
//),
//enabledBorder: UnderlineInputBorder(
//borderSide:
//BorderSide(color: Colors.deepPurple.shade200),
//),
//contentPadding: EdgeInsets.only(top: 15),
//focusedBorder: UnderlineInputBorder(
//borderSide:
//BorderSide(color: Colors.deepPurple.shade200)),
//labelStyle: TextStyle(
//color: Colors.grey.shade800, fontSize: 16),
//hintText: 'Mobile number'),
//),
//SizedBox(
//height: 16,
//),
//Align(
//alignment: Alignment.topRight,
//child: RaisedButton(
//padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.only(
//topLeft: Radius.circular(20),
//bottomLeft: Radius.circular(20))),
//color: customPurple,
//onPressed: () {},
//child: Text(
//'CONTINUE',
//textAlign: TextAlign.center,
//style: TextStyle(
//color: Colors.white,
//),
//),
//),
//),
//],
//),
//),
//),
//SizedBox(height: 120),
//Row(
//children: <Widget>[
//Container(
//margin: EdgeInsets.only(right: 10),
//height: 90,
//width: 45,
//decoration: BoxDecoration(
//color: customPurple,
//borderRadius: BorderRadius.only(
//topRight: Radius.circular(120),
//bottomRight: Radius.circular(120))),
//),
//CircleAvatar(
//backgroundColor: customPurple,
//radius: 17,
//),
//],
//)
//],
//)

import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color1, color2])),
                ),
                clipper: TopClipper(),
              ),
              ClipPath(
                child: Container(
                  height: 330,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        color1.withOpacity(0.3),
                        color2.withOpacity(0.3)
                      ])),
                ),
                clipper: BottomClipper(),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 50, left: 20, right: 20),
                child: Text(
                  'Welcome.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone_android,
                        size: 20,
                        color: Colors.grey.shade800,
                      ),
                      labelStyle:
                          TextStyle(color: Colors.grey.shade800, fontSize: 16),
                      labelText: 'Phone number'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
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
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

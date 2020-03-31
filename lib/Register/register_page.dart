import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/user_home_page.dart';
import 'package:complaint_managament_system/widgets/custom_button.dart';
import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Register extends StatelessWidget {
  final String mobile;

  Register({Key key, this.mobile}) : super(key: key);

  static open(context, mobile) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => Register(mobile: mobile)));

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height / 2.2,
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
                  height: MediaQuery.of(context).size.height / 2 + 10,
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
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: Text(
              'Registeration',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: nameCtrl,
                    validator: (value) => value.trim().length == 0
                        ? 'Please enter your name'
                        : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16),
                        labelText: 'Enter name'),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16),
                        labelText: 'Enter email  (optional)'),
                  ),
                  SizedBox(height: 35),
                  CustomButton(
                    onTap: () async {
                      if (!formKey.currentState.validate()) return;
                      final snap = await FirebaseDatabase.instance
                          .reference()
                          .child('users')
                          .child(await Prefs.getUID())
                          .set({
                        'name': nameCtrl.text,
                        'email': emailCtrl.text,
                        'mobile': mobile
                      });
                      Prefs.setName(nameCtrl.text);
                      Prefs.setMob(mobile);
                      UserHomePage.openAndRemoveUntil(context);
                      try {} catch (e) {
                        Toast.show(e.toString(), context, duration: 3);
                      }
                    },
                    next: 'REGISTER',
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

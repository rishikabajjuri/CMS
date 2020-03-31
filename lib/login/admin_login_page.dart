import 'package:complaint_managament_system/Register/register_page.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/admin_home_page.dart';
import 'package:complaint_managament_system/home/user_home_page.dart';
import 'package:complaint_managament_system/login/user_login_verification.dart';
import 'package:complaint_managament_system/widgets/custom_button.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class AdminLoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  static openReplacement(context) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => AdminLoginPage()));

  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
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
                    height: MediaQuery.of(context).size.height / 2 + 5,
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
                      top: 20, bottom: 30, left: 20, right: 20),
                  child: Text(
                    'Welcome.',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: emailCtrl,
                    validator: (value) => value.trim().length == 0
                        ? 'Please enter your email'
                        : null,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16),
                        labelText: 'Email'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: passwordCtrl,
                    validator: (value) => value.trim().length == 0
                        ? 'Please enter your password' //12346
                        : null,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16),
                        labelText: 'Password'),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomButton(
                  onTap: () async {
                    if (!formKey.currentState.validate()) return;
                    LoadingWidget.showLoadingDialog(context);
                    try {
                      final _auth = FirebaseAuth.instance;
                      var result = await _auth.signInWithEmailAndPassword(
                          email: emailCtrl.text, password: passwordCtrl.text);
                      await Prefs.setUID(result.user.uid);
                      AdminHomePage.openAndRemoveUntil(context);
                      print(result.user.email);
                    } catch (e) {
                      print(e);
                    }
                  },
                  next: 'CONTINUE',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

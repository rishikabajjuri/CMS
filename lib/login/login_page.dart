import 'package:complaint_managament_system/login/login_verification.dart';
import 'package:complaint_managament_system/widgets/custom_button.dart';
import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color2 = Colors.redAccent;
    final color1 = Colors.red.withOpacity(0.2);
    return Scaffold(
//      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2,
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
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2 + 30,
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
                    controller: controller,
                    validator: (value) =>
                    value
                        .trim()
                        .length == 10
                        ? null
                        : 'Please enter a 10 digit mobile number',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android,
                          size: 20,
                          color: Colors.grey.shade800,
                        ),
                        labelStyle: TextStyle(
                            color: Colors.grey.shade800, fontSize: 16),
                        labelText: 'Phone number'),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  onTap: () {
                    if (!formKey.currentState.validate()) return;
                    final _auth = FirebaseAuth.instance;
                    print(controller.text);
                    _auth.verifyPhoneNumber(
                        phoneNumber: '+91${controller.text}',
                        timeout: Duration(seconds: 10),
                        verificationCompleted: (AuthCredential credentials) async {
                          print('verificationCompleted');
                        },
                        verificationFailed: (ex) {
                          print(ex.message);
                          Toast.show(ex.message, context, duration: 3);
                        },
                        codeSent: (verificationCode, [force]) {
                          print('VerificationCode');
                          print(verificationCode);
                          Navigator.pop(context);
                          LoginVerification.open(context, verificationCode, controller.text);
                        },
                        codeAutoRetrievalTimeout: (ds) {
                          print(ds);
                          print('Timeout');
                        });
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

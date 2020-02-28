import 'package:complaint_managament_system/widgets/custom_button.dart';
import 'package:complaint_managament_system/widgets/otpFields.dart';
import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginVerification extends StatefulWidget {
  final String verificationCode;
  final String mobile;

  const LoginVerification({Key key, this.verificationCode, this.mobile})
      : super(key: key);

  static open(context, String verificationCode, String mobile) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LoginVerification(
                    verificationCode: verificationCode,
                    mobile: mobile,
                  )));

  @override
  _LoginVerificationState createState() => _LoginVerificationState(verificationCode, mobile);
}

class _LoginVerificationState extends State<LoginVerification> {
  List<TextEditingController> controllers = [];

  final formKey = GlobalKey<FormState>();
  final String verificationCode;
  final String mobile;

  _LoginVerificationState(this.verificationCode, this.mobile);

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
                  height: MediaQuery.of(context).size.height / 2,
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
                  height: MediaQuery.of(context).size.height / 2 + 30,
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
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Verification Code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Please verify the OTP sent to your number',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.5,
                        color: Colors.black87,
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                OtpFields(
                  length: 6,
                  controllers: controllers,
                  formKey: formKey,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomButton(
                  next: 'SUBMIT',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:complaint_managament_system/Register/register_page.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/user_home_page.dart';
import 'package:complaint_managament_system/widgets/custom_button.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:complaint_managament_system/widgets/otpFields.dart';
import 'package:complaint_managament_system/widgets/top_bottom_clipper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

class UserLoginVerification extends StatefulWidget {
  final String verificationCode;
  final String mobile;

  const UserLoginVerification({Key key, this.verificationCode, this.mobile})
      : super(key: key);

  static open(context, String verificationCode, String mobile) =>
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserLoginVerification(
                    verificationCode: verificationCode,
                    mobile: mobile,
                  )));

  @override
  _UserLoginVerificationState createState() => _UserLoginVerificationState(verificationCode, mobile);
}

class _UserLoginVerificationState extends State<UserLoginVerification> {
  List<TextEditingController> controllers = [];

  final formKey = GlobalKey<FormState>();
  final String verificationCode;
  final String mobile;

  _UserLoginVerificationState(this.verificationCode, this.mobile);

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
                  onTap: () async {
                    if (!formKey.currentState.validate()) return;
                    final auth = FirebaseAuth.instance;
                    String smsCode = '';
                    controllers.forEach((f) {
                      smsCode += f.text;
                    });
                    final credential = PhoneAuthProvider.getCredential(
                        verificationId: widget.verificationCode, smsCode: smsCode);
                    try {
                      LoadingWidget.showLoadingDialog(context);
                      final authRes = await auth.signInWithCredential(credential);
                      Prefs.setUID(authRes.user.uid);
                      final snap = await FirebaseDatabase.instance
                          .reference()
                          .child('users')
                          .once();
                      final response = snap.value as Map;
                      Navigator.pop(context);
                      final uid = authRes.user.uid;
                      if (response == null || !response.containsKey(uid)) {
                        Register.open(context, widget.mobile);
                      } else {
                        Prefs.setName(response[uid]['name']);
                        Prefs.setMob(response[uid]['mobile']);
//                        Prefs.setRole(response[uid]['role']);
                        UserHomePage.openAndRemoveUntil(context);
                      }
                    } catch (e) {
                      Toast.show(e.toString(), context, duration: 3);
                      Navigator.pop(context);
                      print(e);
                    };
                  },
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

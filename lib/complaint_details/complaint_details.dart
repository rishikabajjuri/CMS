import 'package:complaint_managament_system/complaint_details/complaint_details_section.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/admin_home_page.dart';
import 'package:complaint_managament_system/widgets/custom_dismissible.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  final Map complaint;
  final String date;
  final String mobile;
  final String name;
  final String email;
  final String userId;

  const ComplaintDetails(
      {Key key, this.complaint, this.date, this.mobile, this.name, this.email, this.userId})
      : super(key: key);

  static open(context, complaint, date, mobile, name, email, userId) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ComplaintDetails(
                complaint: complaint,
                date: date,
                mobile: mobile,
                name: name,
                email: email,
            userId: userId,
              )));

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Complaint Details'),
          centerTitle: true,
        ),
        bottomSheet: widget.complaint['status'] == 'pending'
            ? CustomDismissible(
                onDismiss: (value) async {
                  LoadingWidget.showLoadingDialog(context);
                  FirebaseDatabase.instance
                      .reference()
                      .child('users')
                      .child(widget.userId)
                      .child(widget.complaint['status'])
                      .set('completed');
                  AdminHomePage.openAndRemoveUntil(context);
                  return false;
                },
              )
            : Container(height: 1, width: 1),
        body: Container(
          color: Colors.grey.shade50,
          child: ComplaintDetailsSection(
            complaint: widget.complaint,
            date: widget.date,
            mobile: widget.mobile,
            email: widget.email,
            name: widget.name,
            userId: widget.userId,
          ),
        ));
  }
}

import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/widgets/admin_custom_card.dart';
import 'package:complaint_managament_system/widgets/complaint_details_section.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplaintDetails extends StatefulWidget {
  final Map complaint;
  final Map date;


  const ComplaintDetails({Key key, this.complaint, this.date}) : super(key: key);

  static open(context, complaint, date) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ComplaintDetails(
                complaint: complaint,date: date,
              )));

  @override
  _ComplaintDetailsState createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  Future future;
  String uid = '';

  Future<DataSnapshot> getDetails() async {
    uid = await Prefs.getUID();
    var response = await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid)
        .once();
    return response;
  }

  @override
  void initState() {
    super.initState();
    future = getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Complaint Details'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
//        child: ComplaintDetailsSection(
//          complaint: widget.complaint,
//        ),
      )
    );
  }
}

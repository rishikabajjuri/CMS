import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/widgets/admin_custom_card.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ComplaintDetailsSection extends StatefulWidget {
  final Map complaint;


  const ComplaintDetailsSection({Key key, this.complaint}) : super(key: key);

  @override
  _ComplaintDetailsSectionState createState() =>
      _ComplaintDetailsSectionState();
}

class _ComplaintDetailsSectionState extends State<ComplaintDetailsSection> {
  Future future;
  String uid = '';
//  String mobile = '';
//  String email = '';

  Future<DataSnapshot> getDetails() async {
    uid = await Prefs.getUID();
//    mobile = await Prefs.getMob();
//    email = await Prefs.getEmailId();
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
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future: future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.complaint['deptName'],
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.w600),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: AdminCustomCard
                                        .status[widget.complaint['status']]
                                    ['color'],
                              ),
                              child: Text(
                                AdminCustomCard
                                        .status[widget.complaint['status']]
                                    ['value'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone, size: 25,),
                            Column(
                              children: <Widget>[
//                                Text(widget.complaint['deptName']),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
//              return Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 30, horizontal: 20),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text(
//                          widget.complaint['deptName'],
//                          style: TextStyle(
//                              fontSize: 30, fontWeight: FontWeight.w300),
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(top: 5, bottom: 5),
//                          width: 60,
//                          decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(7),
//                            color: AdminCustomCard
//                                .status[widget.complaint['status']]['color'],
//                          ),
//                          child: Text(
//                            AdminCustomCard.status[widget.complaint['status']]
//                            ['value'],
//                            textAlign: TextAlign.center,
//                            style:
//                            TextStyle(color: Colors.white, fontSize: 16),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(
//                        vertical: 20, horizontal: 20),
//                    child: Text(
//                      'Complaint Details',
//                      style: TextStyle(
//                        fontSize: 12,
//                        fontWeight: FontWeight.w300,
//                      ),
//                    ),
//                  ),
//                  Row(
//                    children: <Widget>[],
//                  )
//                ],
//              );
            }
            return LoadingWidget();
          },
        )
      ],
    );
  }
}

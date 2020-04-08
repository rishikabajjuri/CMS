import 'package:complaint_managament_system/complaint_details/complaint_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminCustomCard extends StatelessWidget {
  final Map complaint;
  final String date;
  final String mobile;
  final String name;
  final String email;

  static final Map<String, Map<String, dynamic>> status = {
    'pending': {'value': 'In Progress', 'color': Colors.deepOrangeAccent},
    'completed': {'value': 'Completed', 'color': Colors.green},
    'NA': {'value': '', 'color': null},
  };

  const AdminCustomCard(
      {Key key, this.complaint, this.date, this.mobile, this.name, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy  hh:mm a');
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () => ComplaintDetails.open(
            context, complaint, date, mobile, name, email),
        child: Container(
          height: 145,
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.label_important),
                      SizedBox(width: 5),
                      Text(
                        complaint['deptName'],
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black87, fontFamily: 'Nunito_Sans'),
                        children: [
                          TextSpan(
                              text: 'Title: ', style: TextStyle(fontSize: 15)),
                          TextSpan(
                              text: complaint['title'],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
                        ]),
                  ),
                  Divider(
                    color: Colors.black54,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black87, fontFamily: 'Nunito_Sans'),
                        children: [
                          TextSpan(
                            text: 'Request ID: ',
                          ),
                          TextSpan(
                              text: complaint['id'],
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ]),
                  ),
                  SizedBox(height: 7),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.black87, fontFamily: 'Nunito_Sans'),
                        children: [
                          TextSpan(text: 'Date: '),
                          TextSpan(
                              text: dateFormat.format(DateTime.parse(date)),
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

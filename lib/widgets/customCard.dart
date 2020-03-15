import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final Map complaint;
  final String date;

  const CustomCard({Key key, this.complaint, this.date}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMM dd, yyyy  hh:mm a');
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                SizedBox(height: 3,),
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
    );
  }
}

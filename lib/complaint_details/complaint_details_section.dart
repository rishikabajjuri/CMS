import 'package:cached_network_image/cached_network_image.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/widgets/admin_custom_card.dart';
import 'package:complaint_managament_system/widgets/full_screen_image.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ComplaintDetailsSection extends StatefulWidget {
  final Map complaint;
  final String date;
  final String mobile;
  final String name;
  final String email;
  final String userId;

  const ComplaintDetailsSection({Key key,
    this.complaint,
    this.date,
    this.mobile,
    this.name,
    this.email,
    this.userId})
      : super(key: key);

  @override
  _ComplaintDetailsSectionState createState() =>
      _ComplaintDetailsSectionState();
}

class _ComplaintDetailsSectionState extends State<ComplaintDetailsSection> {
  Future imageFuture;

  @override
  void initState() {
    super.initState();
    imageFuture = FirebaseStorage.instance
        .ref()
        .child(widget.userId)
        .child('complaint_image')
        .child(widget.date)
        .getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 15, left: 14, bottom: 8),
                        child: Text(
                          AdminCustomCard.status[widget.complaint['status']]
                          ['value'],
                          style: TextStyle(
                              color: AdminCustomCard
                                  .status[widget.complaint['status']]['color'],
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Name',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(widget.name,
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Contact Info',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text('+91 ${widget.mobile}',
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              child: OutlineButton(
                                onPressed: () {
                                  _launchCaller(widget.mobile);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'CALL',
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .primaryColor
                                          .withOpacity(0.8)),
                                ),
                                borderSide: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                              child: OutlineButton(
                                onPressed: () {
                                  _launchSms(widget.mobile);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  'SMS',
                                  style: TextStyle(color: Colors.black54),
                                ),
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.email,
                              size: 30,
                            ),
                            SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(widget.email,
                                      style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
//                            SizedBox(width: 85),
                            OutlineButton(
                              onPressed: () {
                                _launchEmail(widget.email);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                'EMAIL',
                                style: TextStyle(
                                    color: Theme
                                        .of(context)
                                        .primaryColor
                                        .withOpacity(0.8)),
                              ),
                              borderSide: BorderSide(
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(0.8)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 15, left: 14, bottom: 8),
                        child: Text(
                          widget.complaint['deptName'],
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.title,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Title',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(widget.complaint['title'],
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.description,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(widget.complaint['description'],
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 15, color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Location',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(widget.complaint['location'],
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 13),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 14, bottom: 8),
                child: Text(
                  'Complaint Image',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(height: 15, color: Colors.black),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder(
                  future: imageFuture,
                  builder: (context, snap) {
                    if (snap.hasError)
                      return Center(
                        child: Text(
                          'No Bill Attached!',
                          style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor
                                  .withOpacity(0.8)),
                        ),
                      );
                    if (!snap.hasData) return LoadingWidget();
                    return Hero(
                      tag: 'complaint_image',
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            FullScreenImage.open(context, snap.data);
                          },
                          child: CachedNetworkImage(
                            imageUrl: snap.data,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            errorWidget: (context, url, error) =>
                                Center(
                                  child: Text(
                                    'Error Fetching Bill!',
                                    style: TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor
                                            .withOpacity(0.8)),
                                  ),
                                ),
                            placeholder: (context, url) => LoadingWidget(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

_launchCaller(String mobile) async {
  final mobileUrl = 'tel:$mobile';
  if (mobileUrl == 'tel:$mobile') {
    if (await canLaunch(mobileUrl)) {
      await launch(mobileUrl);
    } else {
      throw 'Could not launch $mobileUrl';
    }
  }
}

_launchSms(String sms) async {
  final smsUrl = 'sms:$sms';
  if (smsUrl == 'sms:$sms') {
    if (await canLaunch(smsUrl)) {
      await launch(smsUrl);
    } else {
      throw 'Could not launch $smsUrl';
    }
  }
}

_launchEmail(String email) async {
  final emailUrl = 'mailto:$email';
  if (emailUrl == 'email:$email') {
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}
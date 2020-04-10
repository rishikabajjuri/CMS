import 'package:complaint_managament_system/complaint_details/choose_dep.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/login/user_login_page.dart';
import 'package:complaint_managament_system/onboarding_screen/onboarding_screen.dart';
import 'package:complaint_managament_system/widgets/user_custom_card.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserHomePage extends StatefulWidget {
  final Map departments;

  const UserHomePage({Key key, this.departments}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();

  static openAndRemoveUntil(context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => UserHomePage()),
      (route) => false);
}

class _UserHomePageState extends State<UserHomePage> {
  int index = 0;
  Future<DataSnapshot> future;
  String uid = '';
  Map complaints;

  Future<DataSnapshot> getDetails() async {
    uid = await Prefs.getUID();
    var response = await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid)
        .once();
    if (response.value.keys.toList().contains('complaints'))
      complaints = response.value['complaints'];
    else
      complaints = {};
    print(uid);
    filterData = complaints;
    return response;
  }

  @override
  void initState() {
    future = getDetails();
    super.initState();
  }

  Map filterData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataSnapshot>(
        future: future,
        builder: (context, snap) {
          if (snap.hasError)
            return Scaffold(body: Center(child: Text(snap.error.toString())));
          if (!snap.hasData) return Scaffold(body: LoadingWidget());
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 100),
              child: Container(
                padding: EdgeInsets.only(top: 40, bottom: 10),
                color: Theme.of(context).primaryColor.withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                        'Are you sure you want to log out?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () async {
                                          await Prefs.logout();
                                          Navigator.pop(context);
                                          return OnBoarding.openReplacement(
                                              context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No'),
                                      )
                                    ],
                                  ));
                        },
                      ),
                      Flexible(
                        child: Card(
                          child: TextField(
                            onChanged: (char) {
                              filterData = {};
                              complaints.forEach((key, value) {
                                if (value['title']
                                    .toLowerCase()
                                    .contains(char.toLowerCase())) {
                                  filterData.addAll({key: value});
                                }
                              });
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: 'Search...',
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                ChooseDepartment.open(context);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: Column(
              children: <Widget>[
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        indicatorColor: Colors.red.withOpacity(0.2),
                        labelColor: Colors.black,
                        tabs: <Widget>[
                          Tab(
                            text: 'Open',
                            icon: Icon(Icons.drafts),
                          ),
                          Tab(
                            text: 'Closed',
                            icon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                          )
                        ],
                        onTap: (index) {
                          this.index = index;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                _getCard(index)
              ],
            ),
          );
        });
  }

  Map<int, String> status = {
    0: 'pending',
    1: 'completed',
  };

  _getCard(int index) {
    if (filterData.length == 0)
      return Flexible(
          child: Center(
              child: Text(
        'No Complaints!',
        style: TextStyle(fontSize: 20),
      )));

    return Flexible(
        child: ListView.builder(
            itemCount: filterData.length,
            itemBuilder: (context, i) {
              var date;
              var complaint;
              date = filterData.keys.toList()[i];
              print(date);
              complaint = filterData[date];

              if (complaint['status'] == status[index]) {
                return UserCustomCard(
                  complaint: complaint,
                  date: date,
                );
              }
              return Container();
            }));
  }
}

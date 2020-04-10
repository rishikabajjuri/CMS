import 'package:complaint_managament_system/complaint_details/choose_dep.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/login/user_login_page.dart';
import 'package:complaint_managament_system/onboarding_screen/onboarding_screen.dart';
import 'package:complaint_managament_system/widgets/admin_custom_card.dart';
import 'package:complaint_managament_system/widgets/user_custom_card.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminHomePage extends StatefulWidget {
  final Map departments;

  const AdminHomePage({Key key, this.departments}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();

  static openAndRemoveUntil(context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => AdminHomePage()),
      (route) => false);
}

class _AdminHomePageState extends State<AdminHomePage> {
  int index = 0;
  Future<DataSnapshot> future;
  String uid = '';

  String searchValue = '';

  Future<DataSnapshot> getDetails() async {
    var response = await FirebaseDatabase.instance.reference().once();
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
                                        onPressed: () {
                                          Prefs.logout();
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
                              searchValue = char;
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
                _getCard(snap.data.value)
              ],
            ),
          );
        });
  }

  Map<int, String> status = {
    0: 'pending',
    1: 'completed',
  };

  _getCard(data) {
    print(data['users'].length);
    if (data['users'].length == 0) {
      Flexible(
        child: Center(
            child: Text(
          'No Complaints',
          style: TextStyle(fontSize: 20),
        )),
      );
    }
    return Flexible(
        child: ListView.builder(
            itemCount: data['users'].length,
            itemBuilder: (context, i) {
              var userId = data['users'].keys.toList()[i];
              print('userId = $userId');
              if (data['users'][userId]['complaints'] != null)
                return Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: data['users'][userId]['complaints'].length,
                        itemBuilder: (context, j) {
                          var mobile = data['users'][userId]['mobile'];
                          var name = data['users'][userId]['name'];
                          var email = data['users'][userId]['email'];
                          var date = data['users'][userId]['complaints']
                              .keys
                              .toList()[j];
                          var complaint =
                              data['users'][userId]['complaints'][date];
                          if (complaint['status'] == status[index]) {
                            if (searchValue.length == 0 ||
                                complaint['title']
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()))
                              return AdminCustomCard(
                                complaint: complaint,
                                date: date,
                                mobile: mobile,
                                name: name,
                                email: email,
                                userId: userId,
                              );
                          }
                          return Container();
                        }));
              return Container();
            }));
  }
}

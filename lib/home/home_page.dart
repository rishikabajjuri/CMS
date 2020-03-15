import 'package:complaint_managament_system/complaint_details/choose_dep.dart';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/widgets/customCard.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final Map departments;

  const HomePage({Key key, this.departments}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

  static openAndRemoveUntil(context) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  Future<DataSnapshot> future;
  String uid = '';
  Map complaints;

  Future<DataSnapshot> getDetails() async {
    uid = await Prefs.getUID();
    print(uid);
    var response = await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(uid)
        .once();
    complaints = response.value['complaints'];
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
                        icon: Icon(Icons.border_bottom),
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
              complaint = filterData[date];
//              print(date);
              print(complaint['status']);
              print(status[index]);


              if (complaint['status'] == status[index]) {
                return CustomCard(
                  complaint: complaint,
                  date: date,
                );
              }
              return Container();
            }));
  }
}

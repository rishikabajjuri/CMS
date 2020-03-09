import 'package:complaint_managament_system/complaint_details/choose_dep.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  static openAndRemoveUntil(context) => Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: Container(
          padding: EdgeInsets.only(top: 40, bottom: 10),
          color: Theme.of(context).primaryColor.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Card(
              child: TextField(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ChooseDepartment.open(context);
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      body: ListView(
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
                      icon: Icon(Icons.mail, color: Colors.black,),
                    )
                  ],
                  onTap: (index) {
                    this.index = index;
                    setState(() {});
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

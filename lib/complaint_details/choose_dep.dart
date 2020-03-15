import 'package:complaint_managament_system/complaint_details/add_complaint.dart';
import 'package:complaint_managament_system/util/images.dart';
import 'package:flutter/material.dart';

class ChooseDepartment extends StatefulWidget {
  static open(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => ChooseDepartment()));

  @override
  _ChooseDepartmentState createState() => _ChooseDepartmentState();
}

class _ChooseDepartmentState extends State<ChooseDepartment> {
  final depSec = TextEditingController();
  List<Map<String, String>> departments = [
    {'name': 'RAILWAYS', 'image': Images.railways},
    {'name': 'HOTELS', 'image': Images.hotels},
    {'name': 'GOVERNMENT', 'image': Images.government},
    {'name': 'RESTAURANTS', 'image': Images.restaurant},
    {'name': 'FLIGHTS & AIRPORTS', 'image': Images.airplane},
    {'name': 'E-COMMERCE', 'image': Images.ecom},
    {'name': 'TELECOM & INTERNET', 'image': Images.telecom},
    {'name': 'E-WALLET', 'image': Images.mobilepay},
    {'name': 'BANKING', 'image': Images.banking},
    {'name': 'ROADS', 'image': Images.roads},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
          padding: EdgeInsets.only(top: 10),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: departments.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  AddComplaint.open(context,departments[index]['name']);
                },
                child: GridTile(
                  child: Card(
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Image.asset(
                            departments[index]['image'],
                            width: 80,
                            height: 60,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          departments[index]['name'],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

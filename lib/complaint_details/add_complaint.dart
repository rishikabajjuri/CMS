import 'dart:io';

import 'package:complaint_managament_system/widgets/complaint_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddComplaint extends StatefulWidget {
  static open(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => AddComplaint()));

  @override
  _AddComplaintState createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  File imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Enter complaint details'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
          children: <Widget>[
            TextFormField(
              validator: (value) => value.trim().length == 0
                  ? 'Please enter a department name'
                  : null,
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                  labelText: 'Department name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                validator: (value) => value.trim().length == 0
                    ? 'Please enter a complaint title'
                    : null,
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Complaint title',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                validator: (value) => value.trim().length == 0
                    ? 'Please enter a complaint title'
                    : null,
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Where did it happen?',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                )),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                maxLines: 4,
                validator: (value) => value.trim().length == 0
                    ? 'Please enter a complaint title'
                    : null,
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Complaint description',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade600)),
                )),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12))),
                ),
                imageFile == null
                    ? Container()
                    : Positioned.fill(
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      )
              ],
            ),
            ComplaintImage(
              onPick: (image) {
                setState(() {
                  imageFile = image;
                });
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Save'),
        icon: Icon(Icons.check),
      ),
    );
  }
}

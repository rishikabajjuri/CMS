import 'dart:io';
import 'package:complaint_managament_system/data/local/shared_prefs.dart';
import 'package:complaint_managament_system/home/user_home_page.dart';
import 'package:complaint_managament_system/widgets/complaint_image.dart';
import 'package:complaint_managament_system/widgets/google_maps.dart';
import 'package:complaint_managament_system/widgets/google_maps2.dart';
import 'package:complaint_managament_system/widgets/loading_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

class AddComplaint extends StatefulWidget {
  final String departments;

  const AddComplaint({Key key, this.departments}) : super(key: key);

  static open(context, departmentName) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddComplaint(
                departments: departmentName,
              )));

  @override
  _AddComplaintState createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  final formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  File imageFile;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.departments[0].toUpperCase() +
        widget.departments.substring(1).toLowerCase();
  }

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
              enabled: false,
              controller: nameCtrl,
              decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
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
                controller: titleCtrl,
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
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      GoogleMaps2.open(context);
                    },
                    icon: Icon(
                      Icons.location_on,
                      color: Colors.red.shade800,
                    ),
                  ),
                  labelText: '37.4219983°N, 122.084°E',
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
                    ? 'Please enter a complaint description'
                    : null,
                controller: descCtrl,
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
        heroTag: "btn2",
        onPressed: () async {
          if (!formKey.currentState.validate()) return;
          if (imageFile == null) {
            return Toast.show('Please add an image', context);
          }
          LoadingWidget.showLoadingDialog(context);
          final uid = await Prefs.getUID();
          var currentDate = DateTime.now().toString();
          currentDate = currentDate.substring(0, currentDate.indexOf('.'));
          var completeDate = DateTime.now().toString();
          completeDate = completeDate.substring(0, completeDate.indexOf('.'));
          try {
            var id = FirebaseDatabase.instance.reference().push().key;
            if (id.contains('-')) id = id.replaceFirst('-', '');
            id = id.substring(0, 10);
            print(id);
            final image = await FirebaseStorage.instance
                .ref()
                .child(uid)
                .child('complaint_image')
                .child(currentDate)
                .putFile(imageFile)
                .onComplete;
            final data = await FirebaseDatabase.instance
                .reference()
                .child('users')
                .child(uid)
                .child('complaints')
                .child(currentDate)
                .set({
              'deptName': nameCtrl.text,
              'title': titleCtrl.text,
              'location': locationCtrl.text,
              'description': descCtrl.text,
              'status': 'pending',
              'id': id,
              'completeDate': completeDate
            });
            UserHomePage.openAndRemoveUntil(context);
          } catch (e) {
            print(e);
            Navigator.pop(context);
            Toast.show(e.toString(), context, duration: 3);
          }
        },
        label: Text('Save'),
        icon: Icon(Icons.check),
      ),
    );
  }
}

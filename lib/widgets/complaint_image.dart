import 'dart:io';
import 'package:complaint_managament_system/widgets/image_picker.dart';
import 'package:flutter/material.dart';

class ComplaintImage extends StatefulWidget {
  final Function onPick;

  const ComplaintImage({Key key, this.onPick}) : super(key: key);

  @override
  _ComplaintImageState createState() => _ComplaintImageState();
}

class _ComplaintImageState extends State<ComplaintImage> {
  @override
  Widget build(BuildContext context) {
    return ImagePickerContainer(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'ADD IMAGE',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      onPick: (context, imageFile) {
        widget.onPick(imageFile);
      },
    );
  }
}

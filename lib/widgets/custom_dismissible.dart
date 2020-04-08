import 'package:complaint_managament_system/util/images.dart';
import 'package:flutter/material.dart';

class CustomDismissible extends StatelessWidget{
  final Function onDismiss;

  const CustomDismissible({Key key, this.onDismiss}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor.withOpacity(0.8),
      child: Dismissible(
        confirmDismiss: onDismiss,
        direction: DismissDirection.startToEnd,
        key: Key('complete_complaint'),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Images.rightArrow,
                height: 20,
                color: Colors.white24,
              ),
              Image.asset(
                Images.rightArrow,
                height: 20,
                color: Colors.white38,
              ),
              Image.asset(
                Images.rightArrow,
                height: 20,
                color: Colors.white54,
              ),
              Image.asset(
                Images.rightArrow,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: 12),
              Text(
                'SLIDE TO CLOSE COMPLAINT',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

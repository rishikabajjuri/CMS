import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;

  const LoadingWidget({Key key, this.message}) : super(key: key);

  static showLoadingDialog(context) {
    return showDialog(context: context, builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: LoadingWidget()));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    if (message != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              message,
              style: textTheme.caption.copyWith(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_widget.dart';

class FullScreenImage extends StatelessWidget {
  static open(context, url) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => FullScreenImage(
                url: url,
              )));
  final String url;

  const FullScreenImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Center(
        child: Material(
          child: Hero(
            tag: 'expense_image',
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.fill,
              placeholder: (context, url) => LoadingWidget(),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  'Error Fetching Bill!',
                  style: textTheme.caption
                      .copyWith(fontSize: 20, color: Colors.redAccent),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

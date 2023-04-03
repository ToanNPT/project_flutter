import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class ViewHtml extends StatelessWidget {
  final String content;

  ViewHtml({this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: SingleChildScrollView(
            child: Html(data: content, style: {
          "*": Style(
              fontSize: FontSize(16),
              padding: EdgeInsets.only(top: 5, bottom: 10, left: 3, right: 10),
              backgroundColor: Colors.black,
              textAlign: TextAlign.justify,
              color: Colors.white70),
        })));
  }
}

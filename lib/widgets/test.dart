import 'package:flutter/material.dart';

class ExampleWidget extends StatefulWidget {
  final String data;
  ExampleWidget(this.data);

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.data),
    );
  }
}

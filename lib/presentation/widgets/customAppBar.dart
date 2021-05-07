import "package:flutter/material.dart";

class CustomAppBar extends StatefulWidget {
  @override
  _AppBarState createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo Appbar"),
        ),
        body: Text("XXXXXXX"));
  }
}

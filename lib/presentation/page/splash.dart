import 'dart:async';
import 'package:easy/presentation/page/login.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login())));
    // Future.delayed(
    //   Duration(seconds: 5),
    //   () {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => Login(),
    //       ),
    //     );
    //   },
    // );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bg.png'), fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/gigi.gif'), fit: BoxFit.cover),
        ),
      ),
    ));
  }
}

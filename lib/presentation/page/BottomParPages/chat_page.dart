import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // HomeBottomNavBar1.currentTab = 1;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(
        'coming soon',
        style: TextStyle(fontSize: 40, color: Colors.orange[600]),
      ),
    );
  }
}

class _HomeBottomNavBar1State {}

import 'package:flutter/material.dart';

class BottomSheetBuilder extends StatelessWidget {
  Widget widgetToShow;
  BottomSheetBuilder(this.widgetToShow);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).size.height * 0.22,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          gradient:
              LinearGradient(colors: [Colors.orange[50], Colors.orange[100]])),
      // child: Center(child: getFiltersList()),
      child: widgetToShow,
    );
  }
}

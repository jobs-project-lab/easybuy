import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/co.dart';
import 'package:flutter/material.dart';

mixin HomeMixin<T extends StatefulWidget> on State<Home> {
// class HomeMixin extends State<Home>{

  Widget getDropdownButton(context, valueChoose, List<String> listItem) {
    return DropdownButton(
      hint: Text("Choose your Language"),
      isExpanded: true,
      style: TextStyle(
          color: Color.fromRGBO(235, 235, 235, 100),
          fontWeight: FontWeight.normal,
          fontSize: 16),
      value: valueChoose,
      onChanged: (newValue) {
        setState(() {
          valueChoose = newValue;
        });
      },
      items: listItem.map((valueItem) {
        return DropdownMenuItem(
          value: valueItem,
          child: Text(
            valueItem,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }
}

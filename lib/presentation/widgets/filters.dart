import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> dataList = ['kiki1', 'kiki2', 'kiki3'];

  int _site;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 40, left: 30, right: 30),
      child: ListView.builder(
          itemBuilder: (context, index) => itemBuilder(context, dataList)),
    );
  }

  Widget itemBuilder(context, dataList) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.orange),
        gradient: LinearGradient(colors: [
          Colors.orange[100],
          Colors.orange[400],
        ]),
      ),
      child: ExpandablePanel(
        header: Container(
            padding: EdgeInsets.only(top: 10), child: Text('data from back')),
        // collapsed: Text(''),
        expanded: Container(
          height: MediaQuery.of(context).size.height / 3,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.centerLeft,
                width: double.maxFinite,
                height: 40,
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange[100],
                        Colors.orange[400],
                      ],
                    ),
                    border: Border.all(width: 1, color: Colors.orange)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "kikis",
                        textAlign: TextAlign.start,
                      ),
                      Radio(
                        value: 0,
                        groupValue: _site,
                        onChanged: (value) {
                          setState(() {
                            _site = value;
                          });
                        },
                      ),
                    ]),
              );
            },
          ),
        ),
        collapsed: null,
      ),
    );
  }
}

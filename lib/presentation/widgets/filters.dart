import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<String> dataList = ['kiki1', 'kiki2', 'kiki3'];

  int _site;
  String _country = "syria";
  String _cate = "motors";
  String _subcate = "used";
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.only(top: 40, left: 30, right: 30),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: DropdownButtonFormField(
                      value: _country,
                      decoration: InputDecoration(
                          labelText: "Country",
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.orange))),
                      items: [
                        DropdownMenuItem(
                          child: Text("Syria"),
                          value: "syria",
                        ),
                        DropdownMenuItem(
                          child: Text("Saudi Arabia"),
                          value: "ksa",
                        )
                      ],
                      onChanged: (value) {
                        _country = value;
                      },
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField(
                        value: _cate,
                        decoration: InputDecoration(
                            labelText: "Category",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orange))),
                        items: [
                          DropdownMenuItem(
                            child: Text("Motors"),
                            value: "motors",
                          ),
                          DropdownMenuItem(
                            child: Text("Saudi Arabia"),
                            value: "ksa",
                          )
                        ],
                        onChanged: (value) {
                          _cate = value;
                        },
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: DropdownButtonFormField(
                        value: _subcate,
                        decoration: InputDecoration(
                            labelText: "Sub-Category",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orange))),
                        items: [
                          DropdownMenuItem(
                            child: Text("used"),
                            value: "used",
                          ),
                          DropdownMenuItem(
                            child: Text("Saudi Arabia"),
                            value: "ksa",
                          )
                        ],
                        onChanged: (value) {
                          _subcate = value;
                        },
                      )),
                ],
              ))
        ],
      ),
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
            itemCount: 2,
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

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SettingsPage extends StatefulWidget {
  bool hasBar = false;
  SettingsPage(this.hasBar);
//the list of countries will bet got from the back end this just for demo
//
  @override
  _SettingsPageState createState() => _SettingsPageState(hasBar);
}

class _SettingsPageState extends State<SettingsPage> {
  bool hasBar = false;
  _SettingsPageState(this.hasBar);
  String _city = "city1";
  List<String> countList = ["syria"];
  List<String> languages = [
    'العربية',
    'English',
  ];

  static List<String> selectedCountry = [];
  static List<String> selectedLanguage = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: hasBar
            ? PreferredSize(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: AppBar(
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0),
                    centerTitle: true,
                    title: Text("Profile"),
                    automaticallyImplyLeading: true,
                  ),
                ),
                preferredSize: Size.fromHeight(60.0),
              )
            : null,
        body: SingleChildScrollView(
          child: Expanded(
              child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.5,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("images/logo.png"))),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.orange)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: DropdownButtonFormField(
                        value: _city,
                        decoration: InputDecoration(
                            labelText: "Choose Country",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orange))),
                        items: [
                          DropdownMenuItem(
                            child: Text("Syria"),
                            value: "city1",
                          ),
                          DropdownMenuItem(
                            child: Text("UAE"),
                            value: "city2",
                          )
                        ],
                        onChanged: (value) {
                          _city = value;
                        },
                      ),
                    ),
                    //for changing the city
                    //for the language
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: DropdownButtonFormField(
                        value: _city,
                        decoration: InputDecoration(
                            labelText: "Choose language",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 1, color: Colors.orange))),
                        items: [
                          DropdownMenuItem(
                            child: Text("العربية"),
                            value: "city1",
                          ),
                          DropdownMenuItem(
                            child: Text("english"),
                            value: "city2",
                          )
                        ],
                        onChanged: (value) {
                          _city = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.orange)),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text('Contact Number',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text('+963 962 728 510'),
                          Padding(padding: EdgeInsets.only(top: 10)),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text('E-mail',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text('info@easybuy-in.com'),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Text('Social Media',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  icon: Icon(Icons.ac_unit), onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.face), onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ));
  }

  void _openFilterDialog(int which) async {
    await FilterListDialog.display(context,
        listData: which == 1 ? countList : languages, //dataList,
        selectedListData:
            which == 1 ? selectedCountry : selectedLanguage, //selectedData,
        height: 480,
        headlineText: "Select Count",
        searchFieldHintText: "Search Here", choiceChipLabel: (item) {
      return item;
    }, validateSelectedItem: (list, val) {
      return list.contains(val);
    }, onItemSearch: (list, text) {
      if (list.any(
          (element) => element.toLowerCase().contains(text.toLowerCase()))) {
        return list
            .where(
                (element) => element.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    }, onApplyButtonClick: (list) {
      if (list != null) {
        setState(() {
          // selectedData = List.from(list);
          which == 1
              ? selectedCountry = List.from(list)
              : selectedLanguage = List.from(list);
        });
      }
      Navigator.pop(context);
    });
  }
}

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SettingsPage extends StatefulWidget {
//the list of countries will bet got from the back end this just for demo
//
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> countList = ["syria"];
  List<String> languages = [
    'العربية',
    'English',
  ];

  static List<String> selectedCountry = [];
  static List<String> selectedLanguage = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3.5,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.contain, image: AssetImage("images/logo.png"))),
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
                //for changing the city
                GestureDetector(
                  onTap: () {
                    // _openFilterDialog(countList, selectedCountry);
                    _openFilterDialog(1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Text(
                        selectedCountry.length == 0
                            ? 'choose City'
                            : selectedCountry[0],
                        textAlign: TextAlign.start),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20)),
                //for changing the laguage
                GestureDetector(
                  onTap: () {
                    // _openFilterDialog(languages, selectedLanguage);
                    _openFilterDialog(2);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Text(
                      selectedLanguage.length == 0
                          ? 'choose Language'
                          : selectedLanguage[0],
                      textAlign: TextAlign.start,
                    ),
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
                      Text('Contact Number', style: textStyle.headline2),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('+963 962 728 510'),
                      Padding(padding: EdgeInsets.only(top: 10)),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text('E-mail', style: textStyle.headline2),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text('info@easybuy-in.com'),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Social Media', style: textStyle.headline2),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.ac_unit), onPressed: () {}),
                          IconButton(icon: Icon(Icons.face), onPressed: () {}),
                          IconButton(icon: Icon(Icons.face), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

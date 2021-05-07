import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/BottomParPages/chat_page.dart';
import 'package:easy/presentation/page/BottomParPages/main_page.dart';
import 'package:easy/presentation/widgets/productList.dart';
import 'package:easy/presentation/widgets/searchBar.dart';
import 'package:flutter/material.dart';

import 'BottomParPages/profile_page.dart';
import 'BottomParPages/settings_page.dart';

class HomeBottomNavBar extends StatefulWidget {
  String list = '';
  List<CatModel> catList = [];
  List featured = [];
  HomeBottomNavBar(this.catList, this.list, this.featured);
  @override
  _HomeBottomNavBarState createState() => _HomeBottomNavBarState(catList);
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _pageIndex = 0;
  bool _proAppBar = true;
  var listFlag = 2;
  List<CatModel> catList0 = [];
  _HomeBottomNavBarState(this.catList0);
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey appBarKey = new GlobalKey();

  int currentTab = 0; // to keep track of active tab index

  @override
  Widget build(BuildContext context) {
    // final List<Widget> screens = [
    //   MainPage(catList0),
    //   ChatPage(),
    //   ProfilePage(),
    //   SettingsPage(),
    // ]; // to store nested tabs
    // final PageStorageBucket bucket = PageStorageBucket();
    // Widget currentScreen = MainPage(widget.catList);
    return Scaffold(
      key: _scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          key: appBarKey,
          // title: _proAppBar ? Text('') : Text('Home'),
          centerTitle: true,
          actions: [
            _proAppBar == true ? Container() : SearchBar(),
            // (_proAppBar != true && widget.listFlag != 2)
            //     ? Container()
            //     : GestureDetector(
            //         child: Icon(Icons.edit),
            //       ),
            listFlag == 2
                ? GestureDetector(
                    onTap: () {
                      var kiki = _scaffoldkey.currentState as ScaffoldState;
                      kiki.showBottomSheet((context) => bottomSheetBuilder());
                    },
                    child: Icon(
                      Icons.filter_alt,
                    ))
                : Container(),
            Padding(padding: EdgeInsets.only(right: 20)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.orange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'kiki'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'kiki'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'kiki'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'kiki'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'kiki'),
        ],
        onTap: (pageIndex) {
          setState(() {
            _pageIndex = pageIndex;
            // if (_pageIndex == 3) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => ProfilePage()));
            // }
          });
        },
      ),
      body: getBody(_pageIndex, null),
    );
  }

  Widget getBody(index, Widget wid) {
    switch (index) {
      case 0:
        // return MainPage(widget.catList);
        if (widget.list == 'list') {
          return ProductList();
        } else {
          return MainPage(widget.catList, widget.featured);
        }
        break;
      case 1:
        return ChatPage();
        // return MotherFucer1();
        break;
      case 2:

        // return Motherfucer2();
        break;
      case 3:
        // setState(() {
        //   _proAppBar = true;
        // });
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => ProfilePage()));

        return ProfilePage();
    }
  }

  Widget bottomSheetBuilder() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.orange[600]),
    );
  }
}

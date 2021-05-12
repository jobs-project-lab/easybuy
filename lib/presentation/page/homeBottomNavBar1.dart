import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/operaions/countries.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/operaions/users.dart';
import 'package:easy/presentation/page/BottomParPages/chat_page.dart';
import 'package:easy/presentation/page/BottomParPages/profile_page.dart';
import 'package:easy/presentation/page/BottomParPages/settings_page.dart';
import 'package:easy/presentation/widgets/AddNewProduct/ProductDetailsForm.dart';
import 'package:easy/presentation/widgets/bottomSheetBuilder.dart';
import 'package:easy/presentation/widgets/filters.dart';
import 'package:easy/presentation/widgets/productList.dart';
import 'package:easy/presentation/widgets/searchBar.dart';
import 'package:easy/presentation/widgets/sideDrawer.dart';
import 'package:easy/presentation/widgets/AddNewProduct/AddNewProduct.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomParPages/main_page.dart';
import 'co.dart';

class HomeBottomNavBar1 extends StatefulWidget {
  String list = '';
  static int currentTab;
  List<CatModel> catList = [];
  List featured = [];
  String countrySlug;
  static GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  _HomeBottomNavBar1State createState() => _HomeBottomNavBar1State();
}

class _HomeBottomNavBar1State extends State<HomeBottomNavBar1> {
  int _pageIndex = 0;
  bool floatingFlage = false;
  bool _proAppBar = true;
  var listFlag = 2;
  List<CatModel> catList = [];
  String countrySlug;
  List featured = [];

  // static GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  //final GlobalKey appBarKey = new GlobalKey();
  Widget currentScreen;

  // widget.currentTab = 0;
  PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    HomeBottomNavBar1.currentTab = 0; // to keep track of active tab index
    //print(featured);
    initValues();
    currentScreen = MainPage(catList,
        featured); // MainPage(catList0); //Dashboard(); // Our first view in viewport
  }

  Country country = new Country();
  User user = new User();
  Product product = new Product();
  void initValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      try {
        country.slug = prefs.getString("countrySlug");
        country.name = prefs.getString("countryName");
        country.nameAr = prefs.getString("countryNameAr");
        user.id = prefs.getString("userId");
        user.name = prefs.getString("name");
        user.userName = prefs.getString("username");
        user.apiToken = prefs.getString("apiToken");
        user.roleId = prefs.getString("roleId");
        user.phone = prefs.getString("phone");
        user.avatar = prefs.getString("avatar");
        List<CatModel> ctl = await country.getCountryCates(country.slug);
        List ftd = await product.getFeatured(country.slug);
        setState(() {
          catList = ctl;
          featured = ftd;
          countrySlug = country.slug;
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: HomeBottomNavBar1.scaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
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
            // title: _proAppBar ? Text('') : Text('Home'),
            centerTitle: true,
            actions: [
              HomeBottomNavBar1.currentTab == 0 ? SearchBar() : Container(),
              HomeBottomNavBar1.currentTab == 2
                  ? GestureDetector(
                      child: Icon(Icons.edit),
                    )
                  : Container(),
              HomeBottomNavBar1.currentTab == 0 && listFlag == 2
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          floatingFlage = true;
                        });

                        var kiki = HomeBottomNavBar1.scaffoldkey.currentState;
                        kiki
                            .showBottomSheet((context) {
                              return BottomSheetBuilder(Filter());
                            })
                            .closed
                            .then((value) {
                              setState(() {
                                floatingFlage = false;
                              });
                            });
                      },
                      child: Icon(
                        Icons.filter_alt,
                      ))
                  : Container(),
              Padding(padding: EdgeInsets.only(right: 20)),
            ],
          ),
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[700],
        child: floatingFlage == false ? Icon(Icons.add) : Text('Apply'),
        onPressed: () {
          if (floatingFlage) {
            Navigator.pop(context);
            //in case of bottom sheet
          } else {
            var kiki = HomeBottomNavBar1.scaffoldkey.currentState;
            kiki.showBottomSheet((context) {
              return BottomSheetBuilder(ProductDetailsForm());
            }).closed;
            // in case adding add
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getNavBarItem([MainPage(catList, featured), ProductList()],
                        '  Home  ', Icons.home, 0),
                    getNavBarItem([
                      ChatPage(
                        hasBar: false,
                      )
                    ], '    Chat    ', Icons.chat, 1),
                  ]),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getNavBarItem([ProfilePage(false)], 'Profile',
                        Icons.account_circle, 2),
                    getNavBarItem(
                        [SettingsPage(false)], 'Setteings', Icons.settings, 3),
                  ]),
            ],
          ),
        ),
      ),
      drawer: sideDrawer(),
      endDrawer: Drawer(),
    );
  }

  Widget getNavBarItem(List<Widget> pages, title, IconData icon, colorIndex) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () {
        setState(() {
          currentScreen = pages[0]; //MainPage(widget.catList);

          HomeBottomNavBar1.currentTab = colorIndex;
        });
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: HomeBottomNavBar1.currentTab == colorIndex
                  ? Colors.orange
                  : Colors.grey,
            ),
            Text(
              '$title',
              style: TextStyle(
                color: HomeBottomNavBar1.currentTab == colorIndex
                    ? Colors.orange
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:easy/translations.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:easy/operaions/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  static Future<List<CatModel>> getcats(List<CatModel> list) async {
    return await _MyHomePageState.getCates();
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  void initState() {
    getCountries();
    super.initState();
  }

  String valueChoose;

  List<String> listItem = ["English", "العربية"];

//
  Country country = new Country();
  List<Country> countries = [];
  List<int> data = [];
  void getCountries() async {
    List cns = await country.getCountries();
    setState(() {
      countries = cns;
      int i = 0;
      while (i < cns.length) {
        data.add(i);
        i++;
      }
      isLoading = false;
    });
  }

  List<CatModel> list = [];
  List featured = [];
  void getFeatured(String name) async {
    Product product = new Product();
    List fts = await product.getFeatured(name);
    //print(fts);
    setState(() {
      featured = fts;
    });
  }

  static Future<List<CatModel>> getCates() async {
    Country country = new Country();
    List<CatModel> lit =
        await country.getCountryCates(_MyHomePageState.countryNam);
    return lit;
  }

  void getCts() async {
    //Country country = new Country();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //List<CatModel> lit = await country.getCountryCates(countrySlug);
    setState(() {
      prefs.setString("countrySlug", countrySlug);
      //list.clear();
      //list = lit;
    });
  }

  String countrySlug;
  static String countryNam;
  bool isLoading = true;
  Widget _buildItemList(BuildContext context, int index) {
    if (index == data.length)
      return Center(
        child: CircularProgressIndicator(),
      );
    return GestureDetector(
      onTap: () {
        setState(() {
          countrySlug = countries[index].slug;
          countryNam = countries[index].slug;
        });
        getCts();
        getFeatured(countries[index].name);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeBottomNavBar1()));
      },
      child: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(countries[index].image),
                      fit: BoxFit.fill)),
            ),
            Container(
              child: Text(
                countries[index].name,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Color(0xffff));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 45, 0, 0),
                //height: 274.5,
                height: MediaQuery.of(context).size.height / 2.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/eee.png'), fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Translations.of(context).text('slog'),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 25),
                    ),
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 30),
                    ),
                  ],
                ),
              ),
              //
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Container(
                width: 260,
                child: Container(
                  child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 235, 235, 100),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 0,
                      ),
                    ),
                    child: DropdownButton(
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
                    ), //getDropdownButton(context, valueChoose, listItem),
                  ),
                ),
              ),
              //
              Padding(
                padding: EdgeInsets.only(top: 65),
              ),
              Container(
                height: 300, //double.infinity,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(80),
                        topRight: Radius.circular(80)),
                    // border: Border.all(
                    //   style: BorderStyle.solid,
                    //   width: 0,
                    // ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 8,
                        blurRadius: 10,
                        offset: Offset(0, 3),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    new Text(
                      "Choose your Country",
                      style: TextStyle(
                        fontFamily: "Netflix",
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        letterSpacing: 0.0,
                        color: Colors.white,
                      ),
                    ),
                    isLoading
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Expanded(
                            child: ScrollSnapList(
                              itemBuilder: _buildItemList,
                              itemSize: 100,
                              dynamicItemSize: true,
                              onReachEnd: () {},
                              itemCount: data.length,
                              onItemFocus: (int) {},
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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

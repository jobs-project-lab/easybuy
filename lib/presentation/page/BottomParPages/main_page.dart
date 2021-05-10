import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/countries.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/page/constants.dart';
import 'package:easy/presentation/page/mixins/mainPageMixin.dart';
import 'package:easy/presentation/widgets/catSlider.dart';
import 'package:easy/presentation/widgets/slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homeBottomNavBar1.dart';

class MainPage extends StatefulWidget {
  List<CatModel> catList = [];
  List featured = [];

  MainPage(this.catList, this.featured);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainPageMixin {
  // List<CatModel> catList = [];
  // _MainPageState(this.catList);
  bool subCat = false;
  List<CatModel> catlist = [];
  List<CatModel> mainList = [];
  List featured = [];
  List<List> featuredSlider = [];
  @override
  void initState() {
    initLists();
    super.initState();
  }

  void initLists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      countrySlug = prefs.getString("countrySlug");
    });
    getFeatured();
    List<CatModel> lst = await getCts();
    setState(() {
      catlist = lst;
      mainList = catlist;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: subCat ? true : false,
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: ListView.builder(
                      itemCount: mainList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            List<CatModel> catList0 =
                                await getSubCates(mainList[index].slug);
                            List<CatModel> main = await getCts();
                            setState(() {
                              catlist.clear();
                              catlist = catList0;
                              mainList = main;
                              isLoading = false;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(2),
                            margin: EdgeInsets.only(bottom: 5, right: 5),
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(width: 1, color: Colors.orange)),
                            child: Text(mainList[index].lable,
                                textAlign: TextAlign.center),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                //the categories grid
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1.1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors
                                        .white, //Color.fromRGBO(230, 230, 255, 0.5),
                                    border: Border.all(
                                        width: 0.5, color: Colors.orange)),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //con for the img
                                    catlist[index] == null
                                        ? Container()
                                        : Container(
                                            width: 70,
                                            height: 70,
                                            padding: EdgeInsets.all(10),
                                            child: Image(
                                              image: NetworkImage(
                                                  catlist[index].photoUrl),
                                              fit: BoxFit.fill,
                                            ),
                                            // Icon(
                                            //   Icons.home,
                                            //   color: Colors.orange,
                                            // ), //NetworkImage(''),
                                          ),
                                    //con for the title
                                    catlist[index] == null
                                        ? Container()
                                        : Container(
                                            child: Text(
                                              catlist[index].lable,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                List<CatModel> catList0 =
                                    await getSubCates(catlist[index].slug);
                                List<CatModel> main = await getCts();
                                setState(() {
                                  catlist.clear();
                                  catlist = catList0;
                                  mainList = main;
                                  subCat = true;
                                  isLoading = false;
                                });
                              },
                            );
                          },
                          childCount: catlist.length,
                        ),
                      ),
                      // featred list
                      featuredLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SliverPadding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return Column(children: [
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: Text(
                                                'Feature for cars',
                                                style: textStyle.headline1,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    top: 10, bottom: 10)),
                                            FeaturesSlider(
                                                3000, countrySlug, "1"),
                                            Container(
                                              height: 130,
                                              margin: EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.all(25),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          featured[index]
                                                              ['image']),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            )
                                          ],
                                        ),
                                      )
                                    ]);
                                  },
                                  childCount: featured.length,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  bool isLoading = true;
  bool featuredLoading = true;
  String countrySlug;
  Future<List<CatModel>> getCts() async {
    Country country = new Country();

    //print(countrySlug);
    List<CatModel> lit = await country.getCountryCates(countrySlug);
    return lit;
  }

  Future<List<CatModel>> getSubCates(String cateName) async {
    Product product = new Product();
    ApiUrl api = new ApiUrl();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      List<CatModel> result = [];
      String countryName = prefs.getString("countryName");
      List data = await product.getSubCategories(countryName, cateName);
      //print(data);
      if (data != null) {
        for (var item in data) {
          CatModel ct = new CatModel(item['id'], api.storageUrl + item['image'],
              item['name'], item['slug']);
          result.add(ct);
        }
        return result;
      }
    }
    return null;
  }

  void getFeatured() async {
    Product product = new Product();
    List fts = await product.getFeatured(countrySlug);
    //print(fts);
    setState(() {
      featured = fts;
      featuredLoading = false;
    });
  }
}

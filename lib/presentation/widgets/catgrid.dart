import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/page/ProductDetailsPage.dart';
import 'package:easy/presentation/page/homeBottomNavBar.dart';
import 'package:easy/presentation/page/BottomParPages/main_page.dart';
import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:easy/presentation/widgets/productList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CatGrid extends StatefulWidget {
  List<CatModel> catList = [];
  final String source;
  List featured = [];
  CatGrid({this.catList, this.source, this.featured});

  @override
  _CatGridState createState() => _CatGridState();
}

class _CatGridState extends State<CatGrid> {
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.1,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return getCategoryItem(context, index, widget.catList);
        },
        childCount: widget.catList.length,
      ),
    );
  }

  Widget getCategoryItem(context, index, List<CatModel> catlist) {
    GlobalKey conKey = GlobalKey();
    // var box = conKey.currentContext.findRenderObject() as RenderBox;
    return GestureDetector(
      child: Container(
        key: conKey,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white, //Color.fromRGBO(230, 230, 255, 0.5),
            border: Border.all(width: 0.5, color: Colors.orange)),
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
                        image: NetworkImage(catlist[index].photoUrl),
                        fit: BoxFit.fill,
                        color: Colors.orange),
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
                      style: TextStyle(color: Colors.orange),
                    ),
                  ),
          ],
        ),
      ),
      onTap: () async {
        List<CatModel> catList0 = await getSubCates(catlist[index].slug);
        //print(catlist[index].lable);
        if (widget.source == 'mainPage') {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    HomeBottomNavBar1(catList0, '', widget.featured),
              ));
        } else if (widget.source == 'addNewProduct') {
          if (widget.catList.length == 0) {
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailsPage()));
          }
        }
      },
    );
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
}

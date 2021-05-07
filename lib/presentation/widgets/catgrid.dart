import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/ProductDetailsPage.dart';
import 'package:easy/presentation/page/homeBottomNavBar.dart';
import 'package:easy/presentation/page/BottomParPages/main_page.dart';
import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:easy/presentation/widgets/productList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      onTap: () {
        List<CatModel> catList0 = [];
        catList0.add(CatModel(null, 'assets/icons/sfdf.png', 'first'));
        catList0.add(CatModel(null, 'assets/icons/sfdf.png', 'second'));
        catList0.add(CatModel(null, 'assets/icons/sfdf.png', 'third'));
        catList0.add(CatModel(null, 'assets/icons/sfdf.png', 'fourth'));
        catList0.add(CatModel(null, 'assets/icons/sfdf.png', 'fifth'));
        // setState(() {
        //   HomeBottomNavBar.wid = MainPage(catList0);
        //   // widget.catList = catList0;
        // });
        if (widget.source == 'mainPage') {
          if (widget.catList[0].photoUrl == 'assets/icons/sfdf.png') {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      HomeBottomNavBar1([], 'list', widget.featured),
                ));
          } else {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      HomeBottomNavBar1(catList0, '', widget.featured),
                ));
          }
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
}

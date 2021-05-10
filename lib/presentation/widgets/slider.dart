import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/page/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy/presentation/page/ProductDetailsPage.dart';

class FeaturesSlider extends StatelessWidget {
  int duration;
  String image, name, des, price;
  String countrySlug;
  String cateId = "0";
  Product product = new Product();
  List slider = [];
  ApiUrl api = new ApiUrl();
  FeaturesSlider(this.duration, this.countrySlug, this.cateId);
  void getSlider() async {
    slider = await product.getFeaturedSlider(countrySlug, cateId);
  }

  @override
  Widget build(BuildContext context) {
    getSlider();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return CarouselSlider.builder(
      itemCount: slider.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductDetailsPage()));
          },
          child: Container(
            alignment: Alignment.center,
            // height: height / 4,
            width: width / 2.7,
            // margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListView(children: [
              Column(
                children: [
                  //image con
                  getImageUI(height, api.storageUrl + slider[index]['image']),
                  // getDateUI(),
                  getNameUI(slider[index]['title']),
                  getDescriptionUI(" "),
                  Container(
                    height: 1,
                    color: Colors.grey[400],
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 25, right: 25),
                  ),
                  getPriceUI(slider[index]['price']),
                ],
              )
            ]),
          ),
        );
      },
      options: CarouselOptions(
        height: 200.0,
        // disableCenter: true,
        viewportFraction: 0.43,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: duration),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
    );
  }

  Widget getImageUI(height, String image) {
    return Container(
      height: height / 7,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.red,
          image: DecorationImage(
            // image: AssetImage(
            //   'images/uaef.png',
            // ),
            image: NetworkImage(
                "https://easybuy-in.com/new/storage/advertisments/January2021/i0XWz3fFdcstPLo2PPpc.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    );
  }

  Widget getDateUI() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 25, top: 5),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 15, //make a theme for it
          ),
          Text(
            '15/4/2021',
            textAlign: TextAlign.left,
            textWidthBasis: TextWidthBasis.longestLine,
            style: textStyle.headline3,
          ),
        ],
      ),
    );
  }

  Widget getNameUI(String name) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 5),
      width: double.infinity,
      child: Text(name, style: textStyle.headline2, textAlign: TextAlign.left),
    );
  }

  Widget getDescriptionUI(String des) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20),
      child: Text(
        "",
        style: textStyle.headline2,
        textAlign: TextAlign.start,
        maxLines: 1,
      ),
    );
  }

  Widget getPriceUI(price) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, top: 5),
      child: Text(
        'Price: $price',
        style: TextStyle(
            fontSize: 15,
            fontFamily: 'Georgia',
            // fontStyle: FontStyle.,
            fontWeight: FontWeight.bold,
            color: Colors.orange[700]),
        textAlign: TextAlign.start,
        maxLines: 1,
      ),
    );
  }
}

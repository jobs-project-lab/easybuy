import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/constants.dart';
import 'package:easy/presentation/page/BottomParPages/main_page.dart';
import 'package:easy/presentation/widgets/slider.dart';
import 'package:flutter/material.dart';

mixin MainPageMixin<T extends StatefulWidget> on State<MainPage> {
  buildGridFromApi() {}
  List<String> items = [
    'cars',
    'moto',
    'whachs',
    'furnitures',
    'taxis',
    'bitch',
    'motherfucker'
  ];
  //for the grid

  // Widget getCategoryGrid(BuildContext context, List<CatModel> catList) {
  //   return SliverGrid(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //       mainAxisSpacing: 10.0,
  //       crossAxisSpacing: 10.0,
  //       childAspectRatio: 1.1,
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (BuildContext context, int index) {
  //         return getCategoryItem(context, index, catList);
  //       },
  //       childCount: catList.length,
  //     ),
  //   );
  // }

  //end grid
  //
  //
  //for the bottom slider
  Widget getSlidersList(context) {
    return widget.featured == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SliverPadding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(children: [
                    getSliderItem(items[0], widget.featured[index])
                  ]);
                },
                childCount: 4,
              ),
            ),
          );
  }

  Widget getSliderItem(cat, feature) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Feature for $cat',
              style: textStyle.headline1,
              textAlign: TextAlign.start,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          FeaturesSlider(3000, "tst", "test", "test", "5000"),
          Container(
            height: 130,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(feature['image']), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}

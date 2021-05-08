import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/co.dart';
import 'package:flutter/material.dart';

class CatSlider extends StatelessWidget {
  List<CatModel> catList = [];
  void getCates() async {
    catList = await Home.getcats([]);
  }

  @override
  Widget build(BuildContext context) {
    getCates();
    return Container(
      width: double.infinity,
      height: 40,
      child: ListView.builder(
        itemCount: catList.length,
        itemBuilder: (context, index) {
          return getItemBuilder(context, catList[index].lable);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget getItemBuilder(context, title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.only(bottom: 5, right: 5),
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 1, color: Colors.orange)),
        child: Text('$title', textAlign: TextAlign.center),
      ),
    );
  }
}

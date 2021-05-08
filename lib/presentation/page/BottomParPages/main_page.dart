import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/mixins/mainPageMixin.dart';
import 'package:easy/presentation/widgets/catSlider.dart';
import 'package:easy/presentation/widgets/catgrid.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  List<CatModel> catList = [];
  List featured = [];
  bool subCat;
  MainPage(this.catList, this.featured, this.subCat);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainPageMixin {
  // List<CatModel> catList = [];
  // _MainPageState(this.catList);
  bool subCat;
  @override
  void initState() {
    subCat = widget.subCat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: false,
            child: CatSlider(),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                Container(child: Text("test")),
                // getCategoryGrid(context, catList),
                getSlidersList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

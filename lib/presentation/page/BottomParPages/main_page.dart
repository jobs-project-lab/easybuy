import 'package:easy/data/models/categoryModel.dart';
import 'package:easy/presentation/page/mixins/mainPageMixin.dart';
import 'package:easy/presentation/widgets/catSlider.dart';
import 'package:easy/presentation/widgets/catgrid.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    try {
      if (widget.catList != null && widget.catList[0] != null)
        subCat =
            widget.catList[0].photoUrl == 'assets/icons/car.png' ? false : true;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: subCat ? true : false,
            child: CatSlider(),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                widget.catList == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : CatGrid(
                        catList: widget.catList,
                        source: 'mainPage',
                      ),
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

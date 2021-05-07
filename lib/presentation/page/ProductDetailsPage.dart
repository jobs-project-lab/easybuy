import 'dart:io';

import 'package:easy/presentation/widgets/ProductDetails/FeaturedAddSliderSection.dart';
import 'package:easy/presentation/widgets/ProductDetails/PropertyInfoSection.dart';
import 'package:easy/presentation/widgets/ProductDetails/productTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy/presentation/widgets/ProductDetails/SliderItem.dart';
import 'package:easy/presentation/widgets/ProductDetails/LocationSection.dart';
//import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_share/social_share.dart';
import 'package:easy/presentation/widgets/ProductDetails/DescriptionSection.dart';
import 'package:easy/presentation/widgets/ProductDetails/PostedBySection.dart';
import 'package:easy/presentation/widgets/ProductDetails/ContactinSection.dart';
import 'package:flutter/services.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:share/share.dart';

class ProductDetailsPage extends StatefulWidget {
  _ProductDetailsPage createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  bool fav = false;

  final double contactingSectionHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        children: [
          Container(
            height:
                MediaQuery.of(context).size.height - contactingSectionHeight,
            child: CustomScrollView(slivers: [
              SliverAppBar(
                backgroundColor: Colors.orange,
                floating: false,
                pinned: true,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: imageSlider(context),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.0),
                  child: Transform.translate(
                    offset: Offset(225, 30),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.favorite,
                                color: fav ? Colors.orange : Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: Colors.orange)),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              fav = !fav;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.share,
                                color: Colors.orange,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 1, color: Colors.orange)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  switch (index) {
                    case 0:
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: ProductTitle(),
                      );
                    case 3:
                      return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: LocationSection());
                    case 1:
                      return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: PropertyInfo());
                    case 2:
                      return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: DescriptionSection());
                    case 4:
                      return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: PostedBySection());
                    case 5:
                      return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: FeaturedAdsSliderSection());
                    default:
                      return SizedBox();
                  }
                }, childCount: 7),
              ),
            ]),
          ),
          Container(
              height: contactingSectionHeight, child: ContactingSection()),
        ],
      ),
    );
  }
}

/* body: SingleChildScrollView(
        child: Container(
          child: imageSlider(context),
          height: MediaQuery.of(context).size.height / 3,
        ),
      ),
*/

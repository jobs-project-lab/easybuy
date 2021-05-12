import 'dart:io';

import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
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
import 'package:slimy_card/slimy_card.dart';
import 'package:social_share/social_share.dart';
import 'package:easy/presentation/widgets/ProductDetails/DescriptionSection.dart';
import 'package:easy/presentation/widgets/ProductDetails/PostedBySection.dart';
import 'package:easy/presentation/widgets/ProductDetails/ContactinSection.dart';
import 'package:flutter/services.dart';
import 'package:social_share_plugin/social_share_plugin.dart';
import 'package:share/share.dart';

class ProductDetailsPage extends StatefulWidget {
  String slug;
  ProductDetailsPage(this.slug);
  _ProductDetailsPage createState() => _ProductDetailsPage(slug);
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  String slug;
  _ProductDetailsPage(this.slug);
  bool isLoading = true;
  bool fav = false;
  Product product = new Product();
  bool empty = false;
  ApiUrl api = new ApiUrl();
  final double contactingSectionHeight = 56.0;
  Map<String, dynamic> data;
  @override
  void initState() {
    getAdsData();
    super.initState();
  }

  void getAdsData() async {
    Map<String, dynamic> details = await product.getProductDetails(slug);
    print(details);
    if (details != null) {
      setState(() {
        data = details;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height -
                      contactingSectionHeight,
                  child: CustomScrollView(slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.orange,
                      floating: false,
                      pinned: true,
                      expandedHeight: 250.0,
                      flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          background:
                              Image.network(api.storageUrl + data['image'])),
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
                            //product Title
                            return Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: Container(
                                padding: EdgeInsets.zero,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['price'].toString(),
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          data['title'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          case 3:
                            return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: LocationSection(data['location']));
                          case 1:
                            return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: SlimyCard(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                    topCardHeight: 200,
                                    bottomCardHeight: 100,
                                    borderRadius: 15,
                                    topCardWidget: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text("Info",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ))),
                                        Divider(),
                                        _getInfoRow(Icons.remove_red_eye,
                                            "views", data['Views'].toString()),
                                        Divider(),
                                        _getInfoRow(
                                            Icons.date_range,
                                            "created at",
                                            data['Created_at'].toString()),
                                        Divider(),
                                        _getInfoRow(
                                            Icons.date_range,
                                            "Expire at",
                                            data['expired_at'].toString())
                                      ],
                                    )));
                          case 2:
                            return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: DescriptionSection(data['body']));
                          case 4:
                            return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: PostedBySection(data['user']['name'],
                                    data['user']['created_at']));
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
                    height: contactingSectionHeight,
                    child: ContactingSection()),
              ],
            ),
    );
  }

  Widget _getInfoRow(IconData icon, String label, String value) {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.orange,
                size: 24,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                label,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
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

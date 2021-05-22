import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/widgets/ProductDetails/updateAds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ProductDetailsPage.dart';

class MyAds extends StatefulWidget {
  @override
  _MyAdsState createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  String apiToken;
  List myAds;
  bool isLoading = true;
  bool isNull = true;
  ApiUrl api = new ApiUrl();
  @override
  void initState() {
    getMyAds();
    super.initState();
  }

  void getMyAds() async {
    Product product = new Product();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apiToken = prefs.getString("apiToken");
    });
    List data = await product.getMyAds(apiToken);
    if (data != null) {
      myAds = [];
      setState(() {
        myAds = data;
        isNull = false;
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget getListItem(item) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.3,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.orange)),
      child: Column(
        children: [
          getImageUI(item['image'], item['id'].toString()),
          getBottomUI(item['title'], item['body'], item['price'].toString(),
              item['created_at']),
        ],
      ),
    );
  }

  Widget getImageUI(String image, String id) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 4,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(api.storageUrl + image),
              ),
            ),
          ),
          Positioned(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  // padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1, color: Colors.orange),
                      color: Colors.black26),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1, color: Colors.orange),
                      color: Colors.black26),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => UpdateAds(
                                id: id,
                              )));
                    },
                  ),
                )
              ],
            ),
            top: 15,
            right: 15,
          ),
        ],
      ),
    );
    // height: MediaQuery.of(context).size.height/3,
  }

  Widget getBottomUI(title, des, price, date) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '$title',
              // textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              des,
              maxLines: 1,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, left: 10, bottom: 5),
            child: Container(
              padding: EdgeInsets.only(right: 90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                  Text(
                    date,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[400]),
          Container(
            padding: EdgeInsets.only(top: 5),
            width: double.infinity,
            child: Text(
              'Price: $price',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange,
                  Colors.red,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: AppBar(
              backgroundColor: Color.fromRGBO(255, 255, 255, 0),
              centerTitle: true,
              title: Text("My Ads"),
              automaticallyImplyLeading: true,
            ),
          ),
          preferredSize: Size.fromHeight(60.0),
        ),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : isNull
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: myAds.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                          myAds[index]['slug'])));
                            },
                            child: getListItem(myAds[index]),
                          );
                        })));
  }
}

import 'package:easy/operaions/apiUrls.dart';
import 'package:easy/operaions/products.dart';
import 'package:easy/presentation/page/ProductDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdsGride extends StatefulWidget {
  final List ads;
  final bool isSearch;
  final String searchText;
  const AdsGride({Key key, this.ads, this.isSearch, this.searchText})
      : super(key: key);
  @override
  _AdsGrideState createState() =>
      _AdsGrideState(ads: ads, isSearch: isSearch, searchText: searchText);
}

class _AdsGrideState extends State<AdsGride> {
  List ads = [];
  bool isNull = false;
  ApiUrl api = new ApiUrl();
  _AdsGrideState({this.ads, this.isSearch, this.searchText});
  bool isSearch = false;
  String searchText;
  bool isLoading = false;

  @override
  void initState() {
    if (isSearch == true) {
      search();
    } else {
      if (ads == null) {
        setState(() {
          isNull = true;
        });
      }
    }
    super.initState();
  }

  void search() async {
    setState(() {
      isLoading = true;
    });
    Product product = new Product();
    List search = await product.search(searchText);
    if (search != null) {
      setState(() {
        ads = search;
        isLoading = false;
        isNull = false;
      });
    }
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
          getImageUI(item['image']),
          getBottomUI(item['title'], item['body'], item['price'].toString(),
              item['created_at']),
        ],
      ),
    );
  }

  Widget getImageUI(String image) {
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
            child: Container(
              // padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.orange)),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
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
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : isNull
            ? Container(child: Text("No Ads Found"))
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(ads[index]['slug'])));
                      },
                      child: getListItem(ads[index]),
                    );
                  },
                  itemCount: ads.length,
                ),
              );
  }
}

import 'package:easy/presentation/page/constants.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return getListItem();
        },
        itemCount: 5,
      ),
    );
  }

  Widget getListItem() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.49,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.orange)),
      child: Column(
        children: [
          getImageUI(),
          getBottomUI('Ford focaus', 'assfa fsdfsd  fsds', '5000000'),
        ],
      ),
    );
  }

  Widget getImageUI() {
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
                image: NetworkImage(
                    'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/2022-chevrolet-corvette-z06-1607016574.jpg?crop=0.737xw:0.738xh;0.181xw,0.218xh&resize=640:*'),
              ),
            ),
          ),
          Positioned(
            child: Container(
              // padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
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

  Widget getBottomUI(title, des, price) {
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
              style: textStyle.headline1,
              // textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              '$des',
              style: textStyle.headline2,
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
                    '25/4/2021',
                    style: textStyle.headline3,
                  ),
                  SizedBox(),
                  Icon(
                    Icons.speed_rounded,
                    color: Colors.black,
                  ),
                  Text(
                    '40000',
                    style: textStyle.headline3,
                  ),
                  SizedBox(),
                  Icon(
                    Icons.calendar_today_sharp,
                    color: Colors.black,
                  ),
                  Text(
                    '2015',
                    style: textStyle.headline3,
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
}

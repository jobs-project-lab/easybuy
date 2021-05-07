import 'package:flutter/material.dart';

class FeaturedAdsSliderItem extends StatefulWidget {
  @override
  _FeatuedAdsSliderItemState createState() => _FeatuedAdsSliderItemState();
}

class _FeatuedAdsSliderItemState extends State<FeaturedAdsSliderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 150,
        // decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.orange, width: 1)),
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/images/market.jpeg',fit: BoxFit.cover,),
              margin: EdgeInsets.only(bottom: 10),
              // decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10.0),border: Border.all(color: Colors.black, width: 1)),
            ),
            Container(
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text('2 months ago'),
                ],
              ),
              margin: EdgeInsets.only(bottom: 10),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, bottom: 10),
              child: Flexible(
                child: Text(
                  'Mac Suti for clothes',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8, bottom: 10),
              child: Flexible(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Divider(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 8, top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    'Price:',
                  ),
                  Text(
                    '30,000 SP',
                    style: TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

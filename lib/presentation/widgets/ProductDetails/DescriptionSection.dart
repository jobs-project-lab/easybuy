import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionSection extends StatefulWidget {
  String des;
  DescriptionSection(this.des);
  @override
  _DescriptionSectionState createState() => _DescriptionSectionState(des);
}

class _DescriptionSectionState extends State<DescriptionSection> {
  String des;
  _DescriptionSectionState(this.des);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Description:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              ReadMoreText(
                des,
                trimLines: 2,
                style: TextStyle(color: Colors.black),
                colorClickableText: Colors.pink,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getRow(IconData icon, String label, String value) {
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

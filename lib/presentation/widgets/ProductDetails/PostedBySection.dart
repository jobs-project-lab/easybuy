import 'package:flutter/material.dart';

class PostedBySection extends StatefulWidget {
  String name, date;
  PostedBySection(this.name, this.date);
  @override
  _PostedBySectionState createState() => _PostedBySectionState(name, date);
}

class _PostedBySectionState extends State<PostedBySection> {
  String name, date;
  _PostedBySectionState(this.name, this.date);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Posted by:',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.share,
                  color: Colors.orange,
                ),
                decoration: BoxDecoration(
                    color: Colors.black54, shape: BoxShape.circle),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Member Since $date',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

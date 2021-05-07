import 'package:flutter/material.dart';

class PostedBySection extends StatefulWidget {
  @override
  _PostedBySectionState createState() => _PostedBySectionState();
}

class _PostedBySectionState extends State<PostedBySection> {
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
                      'Soso',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Member Since Jan 12/2021',
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

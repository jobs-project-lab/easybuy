import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      padding: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '25,000 SP',
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
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Furnished | Ready to move | Spacious | Amazing view',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: Divider(
            //     color: Colors.grey,
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Icon(
            //       Icons.single_bed,
            //       color: Colors.orange,
            //     ),
            //     Text('2 Bedroom'),
            //     SizedBox(),
            //     Icon(
            //       Icons.bathtub_rounded,
            //       color: Colors.orange,
            //     ),
            //     Text('3 Bathroom'),
            //     SizedBox(),
            //     Icon(
            //       Icons.square_foot,
            //       color: Colors.orange,
            //     ),
            //     Text('1,391 Sqft'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';

class PropertyInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.orange[50],
        child: SlimyCard(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          topCardHeight: 200,
          bottomCardHeight: 100,
          borderRadius: 15,
          topCardWidget: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Car Info',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              _getRow(Icons.speed, 'Kilo meters', '111'),
              Divider(
                height: 16,
              ),
              _getRow(Icons.trip_origin_rounded, 'Wheels', '2'),
              Divider(
                height: 16,
              ),
              _getRow(Icons.car_repair, 'Engine Size', 'other'),
              Divider(
                height: 16,
              ),
            ],
          ),
          bottomCardWidget: Column(
            children: [
              _getRow(Icons.remove_red_eye_outlined, 'Condition', 'Good'),
              Divider(
                height: 16,
              ),
              _getRow(Icons.calendar_today_rounded, 'Year', '2021'),
              Divider(
                height: 16,
              ),
            ],
          ),
          slimeEnabled: true,
        ),
      );
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

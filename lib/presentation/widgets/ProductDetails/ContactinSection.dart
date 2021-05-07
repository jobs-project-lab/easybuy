import 'package:easy/presentation/widgets/AddNewProduct/AddNewProduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactingSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactingSection();
  }
}

class _ContactingSection extends State<ContactingSection> {
  bool isPressed = false;
  final String lat = "25.3622";
  final String lng = "86.0835";
  final String contactNumber = '+963966937392';
  var isShown = Permission.contacts.shouldShowRequestRationale;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isPressed = !isPressed;
                if (!isPressed) {
                  launch('tel:${contactNumber}');
                }
              });
            },
            child: Container(
              width: 190,
              height: 56,
              padding: EdgeInsets.all(5),
              child: createButton(
                Colors.blue,
                Colors.white,
                Icons.call,
                !isPressed ? 'Contact me' : ' 0966937392',
              ),
            ),
          ),
          SizedBox(
            width: 1,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>MulipleImagePicker()));
            },
            child: Container(
              width: 190,
              height: 56,
              padding: EdgeInsets.all(5),
              child: createButton(Colors.orange, Colors.white,
                  Icons.chat_bubble_outlined, 'Chat'),
            ),
          ),
        ],
      ),
    );
  }

  Widget createButton(Color backgroundColor, Color textAndIconColor,
      IconData icon, String textLabel) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                icon,
                color: textAndIconColor,
                size: 16,
              ),
            ),
            Text(
              textLabel,
              textAlign: TextAlign.center,
              style: TextStyle(color: textAndIconColor),
            ),
          ],
        ),
      ),
    );
  }
}

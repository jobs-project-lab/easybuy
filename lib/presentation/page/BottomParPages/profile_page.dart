import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy/presentation/page/constants.dart';
import 'package:easy/presentation/widgets/profileCover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../test.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileCover(),
          getProfileDetailsUI('kiki coder', 'syria', '+963999999999'),
          getButtonsUI(context),
        ],
      ),
    );
  }

  Widget getProfileDetailsUI(fullname, location, phoneNumber) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              'Personal Details',
              style: textStyle.headline1,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Full Name: $fullname',
              style: textStyle.headline2,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Location: $location',
              style: textStyle.headline2,
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Phone Number: $phoneNumber',
              style: textStyle.headline2,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Widget getButtonsUI(context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buttonUI('Ads', '0', context),
          buttonUI('Favorite', '0', context),
          buttonUI('Chats', '0', context),
        ],
      ),
    );
  }

  Widget buttonUI(title, counter, context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          // color: Colors.orange,
          border: Border.all(width: 1, color: Colors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              '$title : ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange),
              child: Text(
                '$counter',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:easy/operaions/users.dart';
import 'package:easy/presentation/page/constants.dart';
import 'package:easy/presentation/widgets/profileCover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  bool hasBar = false;
  ProfilePage(this.hasBar);
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState(hasBar);
  }
}

class _ProfilePageState extends State<ProfilePage> {
  bool hasBar = false;
  _ProfilePageState(this.hasBar);
  User user = new User();
  String code, countryName;
  bool isLoading = true;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user.name = prefs.getString("name");
      user.id = prefs.getString('userId');
      user.phone = prefs.getString('phone');
      user.avatar = prefs.getString('avatar');
      user.createdAt = prefs.getString('createdAt');

      countryName = "syria";
      code = prefs.getString('countryCode');
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: hasBar
                ? PreferredSize(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.orange,
                            Colors.red,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: AppBar(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0),
                        centerTitle: true,
                        title: Text("Profile"),
                        automaticallyImplyLeading: true,
                      ),
                    ),
                    preferredSize: Size.fromHeight(60.0),
                  )
                : null,
            body: SingleChildScrollView(
              child: Expanded(
                  child: Column(
                children: [
                  ProfileCover(user.name,
                      DateTime.parse(user.createdAt).toString(), user.avatar),
                  getProfileDetailsUI(user.name, "syria", "+963" + user.phone),
                  getButtonsUI(context),
                ],
              )),
            ));
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
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Location: $location',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'Phone Number: $phoneNumber',
              style: TextStyle(fontWeight: FontWeight.bold),
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

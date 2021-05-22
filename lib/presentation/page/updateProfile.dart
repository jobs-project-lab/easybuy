import 'dart:io';

import 'package:easy/operaions/countries.dart';
import 'package:easy/operaions/users.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  User user = new User();
  String code, countryName;
  bool isLoading = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  Country country = new Country();
  List<DropdownMenuItem> countries = [];
  List<DropdownMenuItem> cities = [];
  String countryId, cityId;
  File image;
  bool hasImage = false;
  String apiToken;
  @override
  void initState() {
    getCountries();
    getUserData();
    super.initState();
  }

  void updateProdile() async {
    SnackBar snackBar = SnackBar(
      content: Row(children: [
        CircularProgressIndicator(
          color: Colors.orange,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Updating info....")
      ]),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    user.updateUser(
        _nameController.text,
        _phoneController.text,
        countryId,
        cityId,
        image,
        _oldPasswordController.text,
        _passwordController.text,
        apiToken,
        context);
  }

  final picker = ImagePicker();
  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("Gallery"),
                      onTap: () async {
                        final pickedFile =
                            await picker.getImage(source: ImageSource.gallery);
                        setState(() {
                          if (pickedFile != null) {
                            image = File(pickedFile.path);
                            hasImage = true;
                          }
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('camera'),
                    onTap: () async {
                      final pickedFile =
                          await picker.getImage(source: ImageSource.camera);
                      setState(() {
                        if (pickedFile != null) {
                          image = File(pickedFile.path);
                          hasImage = true;
                        }
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString("name");
      user.id = prefs.getString('userId');
      _phoneController.text = prefs.getString('phone');
      user.avatar = prefs.getString('avatar');
      user.createdAt = prefs.getString('createdAt');
      apiToken = prefs.getString('apiToken');
      countryName = "syria";
      code = prefs.getString('countryCode');
      countryId = prefs.getString("countryId");
      cityId = prefs.getString("cityId");
    });
  }

  void getCountries() async {
    List<Country> co = await country.getCountries();
    for (var item in co) {
      setState(() {
        countries.add(DropdownMenuItem(
          child: Text(item.name),
          value: item.id,
        ));
      });
    }
    getCities(countryId);
  }

  void getCities(String countryId) async {
    List cts = await country.getCities(countryId);
    cities.clear();
    for (var item in cts) {
      print(item);
      setState(() {
        cities.add(DropdownMenuItem(
          child: Text(item['name']),
          value: item['id'].toString(),
        ));
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
            title: Text("Update Profile"),
            automaticallyImplyLeading: true,
          ),
        ),
        preferredSize: Size.fromHeight(60.0),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 1),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: hasImage
                                ? FileImage(image)
                                : NetworkImage(user.avatar))),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                            top: 50,
                            bottom: 0,
                            right: -15,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.orange[700],
                                size: 30,
                              ),
                              onPressed: () {
                                showPicker(context);
                              },
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        labelText: "Phone",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    controller: _oldPasswordController,
                    decoration: InputDecoration(
                        labelText: "Old Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: "New Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField(
                    value: countryId,
                    onChanged: (value) {
                      setState(() {
                        countryId = value;
                      });
                    },
                    items: countries,
                    decoration: InputDecoration(
                        labelText: "Country",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButtonFormField(
                    value: cityId,
                    onChanged: (value) {
                      setState(() {
                        cityId = value;
                      });
                    },
                    items: cities,
                    decoration: InputDecoration(
                        labelText: "City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35),
                          borderSide:
                              BorderSide(color: Colors.orange, width: 1),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      updateProdile();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35))),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ]),
            ),
    );
  }
}

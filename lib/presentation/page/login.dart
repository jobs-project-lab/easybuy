import 'dart:convert';

import 'package:easy/presentation/page/co.dart';
import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:easy/presentation/page/signup.dart';
import 'package:easy/translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy/operaions/users.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forget.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Login> {
  User user = new User();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Color(0xffff));
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //height: 274.5,
                  height: MediaQuery.of(context).size.height / 2.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/eee.png'),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Translations.of(context).text('welcome'),
                        style: TextStyle(
                            height: 2.5,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 40),
                      ),
                      Text(
                        "Back...",
                        style: TextStyle(
                            height: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 40),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 340,
                  child: Form(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 0),
                              ),
                              labelText: 'Username',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              fillColor: Color.fromRGBO(235, 235, 235, 100),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: new TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 0),
                                ),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    width: 0.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: Color.fromRGBO(235, 235, 235, 100),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 35),
                          ),

                          Container(
                            height: 53,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.red,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(80),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );*/

                                  /*await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          FutureProgressDialog(null,
                                              message: Text('Loading...')));*/

                                  var snackBar = SnackBar(
                                      content: Row(
                                    children: [
                                      CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text("Logging in..."),
                                      )
                                    ],
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  User usr = await user.login(
                                      _userNameController.text,
                                      _passwordController.text);
                                  snackBar =
                                      SnackBar(content: Text(errorMessage));

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  setState(() {
                                    user = usr;
                                    if (user.errorMessage != null) {
                                      errorMessage = user.errorMessage;
                                      snackBar = SnackBar(
                                          content: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(errorMessage),
                                          )
                                        ],
                                      ));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      prefs.setString('userId', user.id);
                                      prefs.setString(
                                          "apiToken", user.apiToken);
                                      prefs.setString("name", user.name);
                                      prefs.setString(
                                          "userName", user.userName);
                                      prefs.setString("roleId", user.roleId);
                                      prefs.setString("phone", user.phone);
                                      prefs.setString("avatar", user.avatar);
                                      prefs.setString(
                                          "createdAt", user.createdAt);
                                      prefs.setString(
                                          "updatedAt", user.updatedAt);
                                      prefs.setString(
                                          "countryId", user.countryId);
                                      prefs.setString("gender", user.gender);
                                      prefs.setString("cityId", user.cityId);
                                      prefs.setString(
                                          "countryName", user.country.name);
                                      prefs.setString(
                                          "countryNameAr", user.country.nameAr);
                                      prefs.setString(
                                          "countrySlug", user.country.slug);
                                      prefs.setString(
                                          "countryCode", user.country.code);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeBottomNavBar1(
                                                      [], '', [], '')));
                                    }
                                  });
                                },
                                child: Text(
                                  'Sign In',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "Netflix",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    letterSpacing: 0.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
//bo
// Row(
                          InkWell(
                            child: Container(
                              height: 70,
                              child: Center(
                                child: Text(
                                  'Continue as Guest',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Home()),
                              );
                            },
                          ),
                          //
                          //
                          InkWell(
                            child: Container(
                              height: 70,
                              child: Center(
                                child: Text(
                                  'Forget Password ?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Forget()),
                              );
                            },
                          ),
                          // Container(
                          //   height: 20,
                          //   child: Center(
                          //     child: Text(
                          //       "Don't have an account? Sign Up",
                          //       style: TextStyle(
                          //           color: Colors.black,
                          //           fontWeight: FontWeight.normal,
                          //           fontSize: 17),
                          //     ),
                          //   ),
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Don't have an account?",
                                style: TextStyle(fontSize: 17),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: GestureDetector(
                                    child: Text("Sign Up",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Colors.blue,
                                            fontSize: 17)),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Signup()),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

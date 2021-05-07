import 'package:easy/presentation/page/co.dart';
import 'package:easy/translations.dart';
import 'package:flutter/material.dart';

class Signup2 extends StatefulWidget {
  Signup2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Signup2> {
  String valueChoose;
  List listItem = ["test", "test"];
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Color(0xffff));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: new SingleChildScrollView(
            child: Column(
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
                        Translations.of(context).text('creat'),
                        style: TextStyle(
                            height: 3.2,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 40),
                      ),
                      Text(
                        "",
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
                  width: 340,
                  child: Form(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
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
                              labelText: 'Phone Number',
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
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: new TextFormField(
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
                                labelText: 'Email Address (optional)',
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
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),

//

                          Center(
                            child: Container(
                              height: 52,
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(235, 235, 235, 100),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0,
                                ),
                              ),
                              child: DropdownButton(
                                  hint: Text("Choose your Country"),
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Color.fromRGBO(235, 235, 235, 100),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                  value: valueChoose,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList()),
                            ),
                          ),
//
//
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Center(
                            child: Container(
                              height: 52,
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(235, 235, 235, 100),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.black,
                                  style: BorderStyle.solid,
                                  width: 0,
                                ),
                              ),
                              child: DropdownButton(
                                  hint: Text("Choose your City"),
                                  isExpanded: true,
                                  style: TextStyle(
                                      color: Color.fromRGBO(235, 235, 235, 100),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                  value: valueChoose,
                                  onChanged: (newValue) {
                                    setState(() {
                                      valueChoose = newValue;
                                    });
                                  },
                                  items: listItem.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList()),
                            ),
                          ),
//
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          Container(
                            height: 53,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: checkBoxValue,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxValue = value;
                                    });
                                  },
                                ),
                                Text("I agree to the Terms and Conditions")
                              ],
                            ),
                          ),
//

                          Padding(
                            padding: EdgeInsets.only(top: 20),
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
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child: Text(
                                  'Continue',
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

import 'package:flutter/material.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeDrawer> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await Future.delayed(Duration(seconds: 1));
    _key.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.orange, Colors.red])),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What are you looking for ?",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  );
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("");
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
        title: cusSearchBar,
      ),
      endDrawer: Drawer(),
      drawer: ClipPath(
        clipper: OvalRightBorderClipper(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 40),
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            width: 300,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black12),
                        image:
                            DecorationImage(image: AssetImage('images/pr.jpg')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Hoveg Morad",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                    ),
                    Text("+963 123 456 789",
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    itemList(Icon(Icons.home, color: Colors.blueGrey[200]),
                        "   Home"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(
                        Icon(Icons.person_pin, color: Colors.blueGrey[200]),
                        "   My profile"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(Icon(Icons.photo, color: Colors.blueGrey[200]),
                        "   My Ads"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(
                        Icon(Icons.chat_outlined, color: Colors.blueGrey[200]),
                        "   Chat"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(Icon(Icons.settings, color: Colors.blueGrey[200]),
                        "   Settings"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(
                        Icon(Icons.brightness_6, color: Colors.blueGrey[200]),
                        "   Dark Mode"),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                    ),
                    itemList(
                        Icon(Icons.info_outline, color: Colors.blueGrey[200]),
                        "   Help"),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }

  Widget itemList(Widget icon, String title) {
    return Row(
      children: [
        icon,
        Text(title, style: TextStyle(color: Colors.black)),
      ],
    );
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 50, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

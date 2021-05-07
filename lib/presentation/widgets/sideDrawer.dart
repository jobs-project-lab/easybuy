import 'package:easy/presentation/page/BottomParPages/chat_page.dart';
import 'package:easy/presentation/page/BottomParPages/profile_page.dart';
import 'package:easy/presentation/page/login.dart';
import 'package:flutter/material.dart';

class sideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
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
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.pravatar.cc/300')), //AssetImage('images/pr.jpg')),
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
                    padding: EdgeInsets.only(top: 10),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.blueGrey[200]),
                    title: Text('Home'),
                    onTap: () {
                      // change app state...
                      Navigator.pop(context); // close the drawer
                    },
                  ),
                  // ListTile(
                  //     Icon(Icons.home, color: Colors.blueGrey[200]), "   Home"),
                  Divider(),

                  ListTile(
                    leading:
                        Icon(Icons.person_pin, color: Colors.blueGrey[200]),
                    title: Text('My profile'),
                    onTap: () {
                      // change app state...
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                      // close the drawer
                    },
                  ),
                  Divider(),

                  ListTile(
                    leading: Icon(Icons.photo, color: Colors.blueGrey[200]),
                    title: Text('My Ads'),
                    onTap: () {
                      // change app state...
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.chat_outlined, color: Colors.blueGrey[200]),
                    title: Text('Chat'),
                    onTap: () {
                      // change app state...
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      );
                    },
                  ),

                  Divider(),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.blueGrey[200]),
                    title: Text('Settings'),
                    onTap: () {
                      // change app state...
                      Navigator.pop(context); // close the drawer
                    },
                  ),

                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.brightness_6, color: Colors.blueGrey[200]),
                    title: Text('Dark Mode'),
                    onTap: () {
                      // change app state...
                      Navigator.pop(context); // close the drawer
                    },
                  ),

                  Divider(),
                  ListTile(
                    leading:
                        Icon(Icons.info_outline, color: Colors.blueGrey[200]),
                    title: Text('Help'),
                    onTap: () {
                      // change app state...
                      Navigator.pop(context); // close the drawer
                    },
                  ),

                  Divider(),
                ],
              ),
            ),
          ),
        ),
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

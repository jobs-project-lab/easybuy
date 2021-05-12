import 'package:easy/presentation/page/homeBottomNavBar1.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  bool hasBar = false;
  ChatPage({this.hasBar});
  @override
  _ChatPageState createState() => _ChatPageState(hasBar: hasBar);
}

class _ChatPageState extends State<ChatPage> {
  bool hasBar = false;
  bool isLoading = true;
  _ChatPageState({this.hasBar});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  title: Text("Chats"),
                  automaticallyImplyLeading: true,
                ),
              ),
              preferredSize: Size.fromHeight(60.0),
            )
          : null,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 75,
                              height: 75,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://picsum.photos/200"),
                                      fit: BoxFit.fill)),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "mohammad",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "hello",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("2-10-2021",
                                style: TextStyle(color: Colors.grey))
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            }),
      ),
    );
  }
}

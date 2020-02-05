import 'package:flutter/material.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youroute/screens/addpost.dart';
import 'package:youroute/screens/login.dart';
import 'package:youroute/screens/posts.dart';
import 'package:youroute/screens/routepage.dart';


class Homepage extends StatefulWidget {
  final name;
  Homepage({this.name});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool addposttab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 253, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage('assets/images/four.jpg'),
                      fit: BoxFit.cover
                  )
              ),
              child: Transform.translate(
                offset: Offset(15, -15),
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.yellow[800]
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: Colors.green,
        inactiveIconColor: Colors.green,
        tabs: [
          TabData(iconData: Icons.home, title: "Te gjitha",),
          TabData(iconData: Icons.add, title: "Shto")
        ],
        onTabChangedListener: (position) {
          if(addposttab){
            setState(() {
              addposttab=false;
            });
          }else{
            setState(() {
              addposttab = true;
            });
          }
        },
      ),
      body: addposttab ? AddPostPage() : PostsPage()
    );
  }

}

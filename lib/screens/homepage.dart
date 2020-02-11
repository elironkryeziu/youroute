import 'package:flutter/material.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youroute/screens/addpost.dart';
import 'package:youroute/screens/login.dart';
import 'package:youroute/screens/posts.dart';
import 'package:youroute/screens/routepage.dart';
import 'package:youroute/components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  final name;
  Homepage({this.name});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final dbReference = Firestore.instance;
  SharedPreferences prefs;
  FirebaseUser user;
  String name,email;

  void getUser() async{
    user = await FirebaseAuth.instance.currentUser();
    prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name");
    email = prefs.getString("email");

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  bool addposttab = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 248, 253, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: new IconThemeData(color: Color.fromRGBO(68, 68, 68, 1)),
        elevation: 0,
        brightness: Brightness.light,
      ),
      drawer: MyDrawer(),
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatefulWidget {
  final userName;
  final userEmail;
  MyDrawer({this.userName,this.userEmail});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final dbReference = Firestore.instance;
  SharedPreferences prefs;

  void getData() async{
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(prefs.getString("name"),style: TextStyle(color: Colors.black,)),
            accountEmail: Text(prefs.getString("email"),style: TextStyle(color: Colors.black,)),
            currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(prefs.getString("name")[0],style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
              decoration: new BoxDecoration(
                  color: Color.fromRGBO(249, 249, 249, 1)
              )
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(
                "Home",
              ),
              leading: Icon(Icons.home),
            ),
          ),
        ],
      ),
    );
  }
}


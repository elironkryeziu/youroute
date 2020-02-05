import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyDrawer extends StatefulWidget {
  final userName;
  final userEmail;
  MyDrawer({this.userName,this.userEmail});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final dbReference = Firestore.instance;
  FirebaseUser user;

  void getUser() async{
    user = await FirebaseAuth.instance.currentUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(user.displayName,style: TextStyle(color: Colors.black,)),
            accountEmail: Text(user.email,style: TextStyle(color: Colors.black,)),
            currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Text(user.displayName[0],style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
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


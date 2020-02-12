import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youroute/screens/homepage.dart';
import 'package:youroute/screens/login.dart';
import 'package:youroute/screens/myposts.dart';
import 'package:youroute/screens/profile.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final dbReference = Firestore.instance;
  FirebaseUser user;

  Future<FirebaseUser> getUser() async{
    user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if (snapshot.data == null) {
        return Container(
          child: Center(
            child: CircularProgressIndicator()));
        } else {
          return ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
            accountName: Text(user.displayName ,style: TextStyle(color: Colors.black,)),
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Homepage()
                  ));
                },
                child: ListTile(
                  title: Text(
                    "Faqja Kryesore",
                  ),
                  leading: Icon(Icons.home),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyPosts()
                  ));
                },
                child: ListTile(
                  title: Text(
                    "Postimet e mija",
                  ),
                  leading: Icon(Icons.inbox),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyProfile()
                  ));
                },
                child: ListTile(
                  title: Text(
                    "Profili",
                  ),
                  leading: Icon(Icons.person),
                ),
              ),
              Divider(),
              InkWell(
                onTap: () {
                  _signOut();
                },
                child: ListTile(
                  title: Text(
                    "Dil",
                  ),
                  leading: Icon(Icons.exit_to_app),
                ),
              ),
            ],
          );
        }
    }
    )
    );
  }
}


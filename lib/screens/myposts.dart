import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youroute/components/drawer.dart';
import 'package:youroute/components/card.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final dbReference = Firestore.instance;
  FirebaseUser user;
  String name,email;

  Future<FirebaseUser> getUser() async{
    user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

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
      body: Container(
      color: Colors.white,
        child: FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.data == null) {
          return Container(
            child: Center(
              child: CircularProgressIndicator()));
          } else {
            return Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Postimet e mija:", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                    child: StreamBuilder(
                      stream: dbReference.collection("routes").where('user_id',isEqualTo: user.uid).snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData) return const Text('Loading...');
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => makeCard(context,snapshot.data.documents[index]),
                        );
                      },
                    )
                ),
              ),
            ],
          ),
        );
          }
        }
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youroute/components/card.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white
              ),
              child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey,),
                      hintText: "Search ",
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                child: StreamBuilder(
                  stream: databaseReference.collection("routes").snapshots(),
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
      )
    );
  }
}



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youroute/screens/routepage.dart';


Widget makeCard(BuildContext context, DocumentSnapshot document) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RoutePage(id: document.documentID)
              ));
            },
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [
                        Colors.greenAccent.withOpacity(.2),
                        Colors.green.withOpacity(.6),
                      ]
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(document['from'], style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(width: 5,),
                      Icon(Icons.arrow_forward, color: Colors.black87,),
                      SizedBox(width: 5,),
                      Text(document['to'], style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Text("Postuar nga: " + document['driver'], style: TextStyle(color: Colors.black87, fontSize: 13, fontStyle: FontStyle.italic),),
                      SizedBox(width: 5,),
                      Text("|"),
                      SizedBox(width: 5,),
                      Text(document['date'], style: TextStyle(color: Colors.black87, fontSize: 13,fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person, color: Colors.black87,),
                      SizedBox(width: 10,),
                      Text(document['people']+" te lira", style: TextStyle(color: Colors.black87),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.access_time, color: Colors.black87,),
                      SizedBox(width: 10,),
                      Text(document['time'], style: TextStyle(color: Colors.black87),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on, color: Colors.black87,),
                      SizedBox(width: 10,),
                      Text(document['price']+" €/person", style: TextStyle(color: Colors.black87),)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
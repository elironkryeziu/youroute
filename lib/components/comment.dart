import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


Widget comment(BuildContext context, DocumentSnapshot document) {
  Timestamp createdAt = document['createdAt'];
  var format = new DateFormat('d/M, hh:mm');
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1,color: Colors.grey)
      ),
    ),
    child: ListTile(
      leading: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            child: Text(
              document['user_name'][0].toString().toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            backgroundColor: Colors.grey,
          ),
        ],
      ),
      title: Text(document['user_name']),
      subtitle: Text(document['content']),
      trailing: Text(format.format(createdAt.toDate()).toString(),style: TextStyle(color: Colors.grey,fontSize: 11),),
    ),
  );
}
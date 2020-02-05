import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Widget comment(BuildContext context, DocumentSnapshot document) {
  return ListTile(
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
  );
}
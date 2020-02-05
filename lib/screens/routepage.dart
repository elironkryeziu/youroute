import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoutePage extends StatefulWidget {
  final id;
  RoutePage({this.id});
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final _commentController = TextEditingController();
  final dbReference = Firestore.instance;
  FirebaseUser user;
  CollectionReference passangersRef;
  bool _isPassanger = false;

  void addPassanger() async {
    user = await FirebaseAuth.instance.currentUser();
    passangersRef = await dbReference
        .collection("routes")
        .document(widget.id)
        .collection("passangers");
    passangersRef
        .add({'passanger_id': user.uid, 'passanger_name': user.displayName});
  }

  void removePassanger() async {
    user = await FirebaseAuth.instance.currentUser();
    final QuerySnapshot result = await dbReference
        .collection('routes')
        .document(widget.id)
        .collection("passangers")
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    for (var document in documents) {
      if (document['passanger_id'] == user.uid) {
        dbReference
            .collection('routes')
            .document(widget.id)
            .collection("passangers")
            .document(document.documentID)
            .delete();
        setState(() {
          _isPassanger = false;
        });
      }
    }
  }

  void addComment(String comment) async {
    user = await FirebaseAuth.instance.currentUser();
    passangersRef = await dbReference
        .collection("routes")
        .document(widget.id)
        .collection("comments");
    passangersRef.add({
      'user_name': user.displayName,
      'content': comment,
      'createdAt': DateTime.now()
    });
    setState(() {
      _isPassanger = true;
    });
  }

  Future<void> checkIfPassanger() async {
    user = await FirebaseAuth.instance.currentUser();
    final QuerySnapshot result = await dbReference
        .collection('routes')
        .document(widget.id)
        .collection("passangers")
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    for (var document in documents) {
      if (document['passanger_id'] == user.uid) {
        setState(() {
          _isPassanger = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfPassanger();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.green.withOpacity(.8),
            Colors.green,
          ])),
          child: StreamBuilder(
              stream: dbReference
                  .collection("routes")
                  .document(widget.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return _postContent(context, snapshot.data);
              })
          //_postContent(context,documentReference),
          ),
      bottomSheet: _addComment(),
    );
  }

  Widget _addComment() {
    return ListTile(
        title: TextFormField(
          controller: _commentController,
          decoration: InputDecoration(labelText: 'Shkruaj nje koment...'),
        ),
        trailing: OutlineButton(
            onPressed: () {
              if (_commentController.text.isNotEmpty) {
                addComment(_commentController.text.toString());
                _commentController.clear();
              }
            },
            borderSide: BorderSide.none,
            child: Text("Dergo", style: TextStyle(color: Colors.blue))));
  }

  Widget _postContent(BuildContext context, DocumentSnapshot document) {
    showAlertDialog(BuildContext context, bool _isPass) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text("Anuloje"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text("Vazhdo"),
        onPressed: () {
          if (_isPass) {
            removePassanger();
            dbReference.collection("routes").document(widget.id).updateData(
                {'people': (int.parse(document['people']) + 1).toString()});
            Navigator.of(context).pop();
          } else {
            addPassanger();
            dbReference.collection("routes").document(widget.id).updateData(
                {'people': (int.parse(document['people']) - 1).toString()});
            Navigator.of(context).pop();
          }
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alert"),
        content: _isPass
            ? Text("A jeni i sigurte qe doni t'a anuloni kete udhetim?")
            : Text(
                "A jeni i sigurte qe doni t'i bashkangjiteni ketij udhetimi?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 120,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.black87,
                        size: 25,
                      ),
                      Text(
                        document['from'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 11,
                      ),
                      Text("|"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 11,
                      ),
                      Text("|"),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Nisja:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        document['time'],
                      ),
                      VerticalDivider(),
                      Text(
                        "Cmimi:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        document['price'] + " €",
                      ),
                      VerticalDivider(),
                      Text(
                        "Vende te lira:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        document['people'],
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 11,
                      ),
                      Text("|"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.black87,
                        size: 25,
                      ),
                      Text(
                        document['to'],
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                  Divider(),
                  document['comment'].toString().isNotEmpty
                      ? ListTile(
                          leading: Stack(
                            children: <Widget>[
                              CircleAvatar(
                                child: Text(document['driver'][0]
                                    .toString()
                                    .toUpperCase()),
                                backgroundColor: Colors.green,
                              ),
                            ],
                          ),
                          title: Text(document['driver']),
                          subtitle: Text(document['comment']),
                        )
                      : ListTile(),
                  Divider(),
                  !_isPassanger
                      ? Container(
                          height: 40.0,
                          width: 200,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                showAlertDialog(context, false);
                              },
                              child: Center(
                                child: Text(
                                  'Bashkangjitu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 40.0,
                          width: 200,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.blueGrey,
                            color: Colors.grey,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {
                                showAlertDialog(context, true);
                              },
                              child: Center(
                                child: Text(
                                  'Anuloje',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Expanded(
                    child: StreamBuilder(
                        stream: dbReference
                            .collection("routes")
                            .document(widget.id)
                            .collection("comments")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return const Text('Loading...');
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) => _comment(
                                context, snapshot.data.documents[index]),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _comment(BuildContext context, DocumentSnapshot document) {
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

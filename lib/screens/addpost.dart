import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youroute/screens/homepage.dart';


class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final databaseReference = Firestore.instance;

  final _prejController = TextEditingController();
  final _deriController = TextEditingController();
  final _dataNisjesController = TextEditingController();
  final _oraNisjesController = TextEditingController();
  final _cmimiController = TextEditingController();
  final _nrVendeveController = TextEditingController();
  final _commentController = TextEditingController();

  final dateFormat = DateFormat("dd-MM-yyyy");
  final timeFormat = DateFormat("HH:mm");


  void createRecord({from,to,date,time,price,people,comment}) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    CollectionReference ref = await databaseReference.collection("routes");
    ref.add({
      'user_id': user.uid,
      'driver': user.displayName,
      'from': from,
      'to': to,
      'date':date,
      'time': time,
      'price':price,
      'people':people,
      'comment':comment
    });
  }

    @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _prejController,
                        decoration: InputDecoration(
                            labelText: 'Vendi i nisjes:',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      TextFormField(
                        controller: _deriController,
                        decoration: InputDecoration(
                            labelText: 'Lokacioni:',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      DateTimeField(
                        controller: _dataNisjesController,
                        decoration: InputDecoration(
                          labelText: 'Data e nisjes:',
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                        format: dateFormat,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      DateTimeField(
                        controller: _oraNisjesController,
                        decoration: InputDecoration(
                        labelText: 'Ora e nisjes:',
                        labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green))),
                        format: timeFormat,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                      ),
                      TextFormField(
                        controller: _cmimiController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Cmimi per person:',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      TextFormField(
                        controller: _nrVendeveController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Numri i vendeve:',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: _commentController,
                        decoration: InputDecoration(
                            labelText: 'Koment shtese:',
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40.0,
                        width: 200,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: () {
                              if(_prejController.text.isNotEmpty && _deriController.text.isNotEmpty && _cmimiController.text.isNotEmpty &&
                                  _dataNisjesController.text.isNotEmpty && _oraNisjesController.text.isNotEmpty && _nrVendeveController.text.isNotEmpty ){
                                createRecord(
                                from: _prejController.text.toString(),
                                to: _deriController.text.toString(),
                                price: _cmimiController.text,
                                date: _dataNisjesController.text.toString(),
                                time: _oraNisjesController.text.toString(),
                                people: _nrVendeveController.text.toString(),
                                  comment: _commentController.text.toString(),
                              );
                                showSuccessDialog(context);
                              }else{
                                showErrorDialog(context);

                              }
                            },
                            child: Center(
                              child: Text(
                                'Shto udhetimin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

showErrorDialog(BuildContext context){
  AlertDialog alert = AlertDialog(
    title: Text("Gabim"),
    content: Text("Ju lutem plotesoni te gjitha fushat"),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showSuccessDialog(BuildContext context) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Homepage()
      ));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Urime"),
    content: Text("Postimi juaj eshte regjistruar me sukses."),
    actions: [
      okButton,
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

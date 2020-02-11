import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youroute/screens/homepage.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final dbReference = Firestore.instance;
  FirebaseUser user;

  Future<FirebaseUser> getUser() async{
    user = await FirebaseAuth.instance.currentUser();
    return user;
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
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           SizedBox(
           height: 120,
         ),
           SizedBox(
             height: 20,
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
                         child: FutureBuilder(
                           future: getUser(),
                           builder: (BuildContext context, AsyncSnapshot snapshot){
                            if (snapshot.data == null) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator()));
                            } else {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text("Te dhenat tuaja:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 25,),
                                  Row(
                                    children: <Widget>[
                                      Text("Emri:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: <Widget>[
                                      Text(user.displayName,style: TextStyle(fontSize: 18),)
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                    children: <Widget>[
                                      Text("Email:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: <Widget>[
                                      Text(user.email,style: TextStyle(fontSize: 18),)
                                    ],
                                  ),
                                ],
                              );
                            }
                           },
                         ),
                       ),
                       SizedBox(height: 80,),
                       Container(
                         height: 40.0,
                         color: Colors.transparent,
                         child: Container(
                           decoration: BoxDecoration(
                               border: Border.all(
                                   color: Colors.black,
                                   style: BorderStyle.solid,
                                   width: 1.0),
                               color: Colors.transparent,
                               borderRadius: BorderRadius.circular(20.0)),
                           child: InkWell(
                             onTap: () {
                               Navigator.of(context).push(MaterialPageRoute(
                                   builder: (context) => Homepage()
                               ));
                             },
                             child:

                             Center(
                               child: Text('Kthehu mbrapa',
                                   style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontFamily: 'Montserrat')),
                             ),


                           ),
                         ),
                       ),
                     ],
                   )
               ),
             ),
           ),

         ],
       ),
      ),
    );
  }
}

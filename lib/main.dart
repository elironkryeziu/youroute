import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youroute/screens/homepage.dart';
import 'package:youroute/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'screens/signup.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  Future<void> _checkLogin() async {
    if(await FirebaseAuth.instance.currentUser() != null){
      _isLoggedIn = true;
    }
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      home: this._isLoggedIn ? Homepage() : LoginPage(),
    );
  }
}

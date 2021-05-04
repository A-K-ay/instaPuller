import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nsta_puller/screens/loginScreen.dart';
import 'package:nsta_puller/screens/searchScreen.dart';
import 'package:nsta_puller/screens/welcomeScreen.dart';
import 'package:nsta_puller/services/authentication.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
//   userCheck(){
//     if(_auth.currentUser != null){
// return SearchScreen();
// }else{
// return WelcomeScreen();
//   }
  userCheck(){
    if(_auth.currentUser != null){
      return SearchScreen();
    }else{return WelcomeScreen();}
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Puller',
      theme: ThemeData.light(
      ),
      home: userCheck(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// if(_auth.currentUser=! null){
// return SearchScreen();
// }else{
// return WelcomeScreen();
// }
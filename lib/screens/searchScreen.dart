import 'package:flutter/material.dart';
import 'package:nsta_puller/components/rounded_button.dart';
import 'package:nsta_puller/components/rounded_input_field.dart';
import 'package:nsta_puller/screens/userScreen.dart';
import 'package:nsta_puller/screens/welcomeScreen.dart';
import 'package:nsta_puller/services/authentication.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  AuthService().signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));

                },
                icon: Icon(
                  Icons.logout,
                )),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 100,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Search Instagram User ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedInputField(
                hintText: "user ID",
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: Hero(
                  tag: "button",
                  child: RoundedButton(
                    text: "Search",
                    width: 250,
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

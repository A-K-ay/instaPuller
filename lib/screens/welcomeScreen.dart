import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nsta_puller/components/rounded_button.dart';
import 'package:nsta_puller/screens/loginScreen.dart';
import 'package:nsta_puller/screens/signUp.dart';
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: SvgPicture.asset('images/HomePageimage.svg')),
            SizedBox(height: 60,),
            RoundedButton(text: "Login", press: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
            },),
            SizedBox(height: 12,),
            RoundedButton(text: "Sign Up", press: (){
              Navigator.push(context, MaterialPageRoute(builder:(context)=>SignUpScreen()));
            },),
            SizedBox(height: 20,),
            Text("Terms of Service & Privacy Policy",style: TextStyle(fontStyle: FontStyle.italic),),
            SizedBox(height: 30,),
          ],

        ),
      ),
    );
  }
}

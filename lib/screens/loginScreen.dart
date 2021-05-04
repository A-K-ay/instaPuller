import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nsta_puller/components/InputFeildNoBorder.dart';
import 'package:nsta_puller/components/already_have_an_account_acheck.dart';
import 'package:nsta_puller/components/rounded_button.dart';
import 'package:nsta_puller/components/rounded_input_field.dart';
import 'package:nsta_puller/components/rounded_password_field.dart';
import 'package:nsta_puller/constants.dart';
import 'package:nsta_puller/screens/searchScreen.dart';
import 'package:nsta_puller/screens/signUp.dart';
import 'package:nsta_puller/services/authentication.dart';
import 'package:nsta_puller/services/fireBackend.dart';
import 'package:nsta_puller/services/responsive.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showProgressIndicator = false;
  final AuthService authService = AuthService();
  final FireBackendServices fireBackendServices = FireBackendServices();
  final formkey =GlobalKey<FormState>();
  FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }
  _showToast(String txt) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Constants.kPrimaryColorSkin,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outlined,color: Colors.redAccent,),
          SizedBox(
            width: 12.0,
          ),
          Text(txt),
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );


  }
  void showSigninerror(){
    _showToast("Sign In error");
  }
  signIn()async{
    if(formkey.currentState.validate()){
      FocusScope.of(context).unfocus();
      setState(() {
        showProgressIndicator = true;
      });
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text).then((value) {if(value == null){
        print("Error in the login sytem either no account like that of no ");
        setState(() {
          setState(() {
            showProgressIndicator = false;
          });
        });
        _showToast("No Such User Exists");
      }});
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchScreen()));
      setState(() {
        showProgressIndicator = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   final double height = Responsive.sHeight(context);
   final double width = Responsive.sWidth(context);

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showProgressIndicator,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: kPrimaryColor,
                height: height*.4
              ),
            ),
            Positioned(
              bottom: 20,
                child: Container(
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400],
                        blurRadius:6.0, // soften the shadow
                        spreadRadius: 1.0, //extend the shadow
                        offset: Offset(
                          2.0, // Move to right 10  horizontally
                          3.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Text('Login',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                          child: InputFeildNoBorder(
                            hintText: "Email Address",
                            onSubmitted: signIn,
                            onChanged: (value) {},
                            controller: emailController,
                            fuc: (val){
                              return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                              null : "Enter a correct email";
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(bottom:Radius.circular(10)),
                          child: RoundedPasswordField( onChanged: (value) {},
                            onSubmitted: signIn,
                            controller: passwordController,
                            fuc: (val){
                              return val.length < 6 ? "Password must be more than 6 characters" : null;
                            },),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RoundedButton(text: "Login",color: kPrimaryColor,press: signIn),
                        ),
                        Text("Forgot Password ?"),
                        SizedBox(height: 40,),
                        AlreadyHaveAnAccountCheck(   press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {

                                return SignUpScreen();
                              },
                            ),
                          );
                        },),
                        SizedBox(height: 20,),

                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

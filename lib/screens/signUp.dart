import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:nsta_puller/components/InputFeildNoBorder.dart';
import 'package:nsta_puller/components/rounded_button.dart';
import 'package:nsta_puller/components/rounded_input_field.dart';
import 'package:nsta_puller/components/rounded_password_field.dart';
import 'package:nsta_puller/constants.dart';
import 'package:nsta_puller/screens/searchScreen.dart';
import 'package:nsta_puller/services/responsive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nsta_puller/services/authentication.dart';
import 'package:nsta_puller/services/fireBackend.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  FToast fToast;
  bool showProgressIndicator = false;
  final formkey =GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final FireBackendServices fireBackendServices = FireBackendServices();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
  void showGoogleSigninerror(){
    _showToast("Google Sign In error.Use email SignUp");
  }
  signUp()async{
    if(formkey.currentState.validate() ){
      if(passwordController.text == passwordCheckController.text){
        FocusScope.of(context).unfocus();
        setState(() {
          showProgressIndicator = true;
        });
        await authService.signUpWithEmailAndPassword(emailController.text, passwordController.text).then((value) {if(value == null){
          print("there was an error");
          setState(() {
            showProgressIndicator = false;
          });
          _showToast("User Exists already");
        }});
        Map<String,String> userMap = {
          "email": emailController.text
        };
        await fireBackendServices.uploadUserInfo(userMap);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
        setState(() {
          showProgressIndicator = false;
        });
      }
      else{
        FocusScope.of(context).unfocus();
        _showToast("Passwords don't match!");
      }
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
                        color: Colors.grey[200],
                        blurRadius:2.0, // soften the shadow
                        spreadRadius: .5, //extend the shadow
                        offset: Offset(
                          1.0, // Move to right 10  horizontally
                          4.0, // Move to bottom 10 Vertically
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
                        child: Text('Sign Up',textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Form(
                            key: formkey,
                            child: Column(
                              children: [
                                ClipRRect(borderRadius: BorderRadius.vertical(top:Radius.circular(10)),
                                  child: InputFeildNoBorder(
                                    hintText: "Your Email",
                                    onChanged: (value) {},
                                    onSubmitted: signUp,
                                    controller: emailController,
                                    fuc: (val){
                                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                                      null : "Enter a correct email";
                                    },
                                  ),
                                ),
                                SizedBox(height: 1,),
                                RoundedPasswordField(    onChanged: (value) {},
                                  onSubmitted: signUp,
                                  controller: passwordController,
                                  fuc: (val){
                                    return val.length < 6 ? "Password must be more than 6 characters" : null;
                                  },),
                                SizedBox(height: 1,),
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(bottom:Radius.circular(10)),
                                  child: RoundedPasswordField(    onChanged: (value) {},
                                    onSubmitted: signUp,
                                    controller: passwordCheckController,
                                    fuc: (val){
                                      return val.length < 6 ? "Password must be more than 6 characters" : null;
                                    },),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40,),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RoundedButton(text: "Continue",color: kPrimaryColor,press:signUp,),
                          ),


                        ],
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/firebase/google_sign_in.dart';
import 'package:look/firebase/signin.dart';
import 'package:look/firebase/signinmobile.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {

    double w=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: w*0.28,bottom: w*0.27),
                child: Image.asset(
                  'assets/look8.png',
                  scale: 5,
                ),
              ),
              button("Log in with Google", 0),
              button("Log in with Gmail", 1),
              button("Log in with Phone Number", 2),
            ],
          ),
        ),
      ),
    );
  }
  Widget button(String txt,int nav)
  {
    double w=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: w*0.07,left: w*0.04,right: w*0.04),
      width: w*0.94,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color:theme().mC,
      ),
      child: TextButton(
        onPressed: ()
        {
          (nav==0)?Authentication().signInWithGoogle(context: context):(nav==1)?Get.to(()=>const SignIn()):Get.to(()=>const SignInPhone());
        },
        child: Text(txt,style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'PopR'),),
      ),
    );
  }
}

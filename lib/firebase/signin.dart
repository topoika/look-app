import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/firebase/signup.dart';
import 'package:look/liveusers/liveusers.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool _passwordVisible=true;
 var _auth1 = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  late String email;
  late String password;


  @override
  @mustCallSuper
  void initState() {
    emailEditingController.text=EMAIL;
  }


  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    TextStyle textstyle= TextStyle(fontSize: w*0.041 ,fontWeight: FontWeight.bold,fontFamily: 'PopR');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:  SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.15, bottom: w * 0.2),
                child: Image.asset(
                  'assets/look8.png',
                  scale: 5,
                ),
              ),
              SizedBox(
                width: w * 1,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: w * 0.09),
                        child: Text(
                          "Email",
                          style: textstyle,
                        ),
                      ),
                      Container(
                        width: w * 0.8,
                        margin: EdgeInsets.only(left: w * 0.09,top: 5),
                        child: TextFormField(
                          validator: (val) {
                            return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                                ? null
                                : "Please Enter Correct Email";
                          },
                          controller: emailEditingController,
                          style: textstyle,
                          decoration:const Dialogg().textFieldInputDecoration("Email", Icons.email),
                          onChanged: (val) {
                            setState(() {
                                email = val;
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.09, top: h * 0.03),
                        child: Text("Password", style: textstyle,),
                      ),
                      Container(
                        width: w * 0.8,
                        margin: EdgeInsets.only(left: w * 0.09,top: 5),
                        child: TextFormField(
                          obscureText: _passwordVisible,
                          validator: (val) {
                            return val!.length > 6
                                ? null
                                : "Enter Password 6+ characters";
                          },
                          controller: passwordEditingController,
                          style: textstyle,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.black26,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.black26,
                                ),
                                onPressed: () {

                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Password",
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                wordSpacing: 3.0,
                              ),
                              hintStyle: const TextStyle(
                                  letterSpacing: 1.3),
                              contentPadding:
                              const EdgeInsets.all(15.0),
                              // Inside box padding
                              border: OutlineInputBorder(
                                  gapPadding: 0.0,
                                  borderRadius:
                                  BorderRadius.circular(15))),
                          onChanged: (value) {
                            setState(
                                  () {
                                password = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async{
                        try {
                          await FirebaseAuth
                              .instance
                              .sendPasswordResetEmail(
                              email:
                              emailEditingController
                                  .text);
                          Dialogg().popUp(context,  'Email has been sent', "Open link you receive and Change your password",1);
                        }
                        catch(e)
                        {
                          const Dialogg().popUp(context,"Fail to reset your password","Try correcting your email",0);
                        }

                    },
                    child: Container(
                        padding:  const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),

                        child: Text(
                          "Forgot Password?         ",
                          style:TextStyle(
                              color: Colors.black,
                              fontFamily: 'PopM',
                              fontSize: w*0.037,
                              ),
                        )),
                  )
                ],
              ),

              Padding(
                padding:  EdgeInsets.only(top: h*0.04,bottom: h*0.07),
                child: buttons("Sign In"),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PopM',
                        fontSize: w*0.04,
                       ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(()=>const SignUp());
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                          color:theme().mC,
                          fontFamily: 'PopM',
                          fontSize: 17,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future signIn(double w,double h) async {

    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await _auth1.signInWithEmailAndPassword(
          email: emailEditingController.text,
          password: passwordEditingController.text,
        );

        Get.to(() => const LiveUsers());

      } catch (e) {
        passwordEditingController.text='';
        setState(() {
          isLoading = false;
        });

        final snackBar = SnackBar(
          margin: const EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
          content: const Text('email and password do not match!'),
          backgroundColor: (Colors.redAccent),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
  Widget buttons(String txt)
  {
    double w=MediaQuery.of(context).size.width;
    double h=MediaQuery.of(context).size.height;
    return Center(
      child: TextButton(
        onPressed: ()
        {
          signIn(w,h);
        },
        child: Container(
          width: w*0.5,
          padding:const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:theme().mC,
          ),
          child: Center(child: (isLoading==false)?Text(txt,style:TextStyle(fontSize: w*0.045,fontWeight: FontWeight.bold,
              color: Colors.white,fontFamily: 'PopR'),):const CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          )),
        ),

      ),
    );
  }
}

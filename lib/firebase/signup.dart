import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/firebase/signin.dart';
import 'package:look/base/pages/termscondition.dart';
import 'package:look/firebase/verify.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  bool _passwordVisible = true;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle textstyle = TextStyle(
        fontSize: w * 0.041, fontWeight: FontWeight.bold, fontFamily: 'PopR');
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
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
                        padding: EdgeInsets.only(left: w * 0.09),
                        child: Text(
                          "Email",
                          style: textstyle,
                        ),
                      ),
                      Container(
                        width: w * 0.8,
                        margin: EdgeInsets.only(left: w * 0.09, top: 5),
                        child: TextFormField(
                          controller: emailEditingController,
                          style: textstyle,
                          decoration: const Dialogg()
                              .textFieldInputDecoration("Email", Icons.email),
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)
                                    ? null
                                    : "Please Enter Correct Email";
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.09, top: h * 0.03),
                        child: Text(
                          "Password",
                          style: textstyle,
                        ),
                      ),
                      Container(
                        width: w * 0.8,
                        margin: EdgeInsets.only(left: w * 0.09, top: 5),
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
                              hintStyle: const TextStyle(letterSpacing: 1.3),
                              contentPadding: const EdgeInsets.all(15.0),
                              // Inside box padding
                              border: OutlineInputBorder(
                                  gapPadding: 0.0,
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h * 0.08, bottom: h * 0.07),
                child: buttons("Sign Up"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PopM',
                      fontSize: w * 0.04,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const SignIn());
                    },
                    child: Text(
                      " Sign In",
                      style: TextStyle(
                          color: theme().mC,
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

  Widget textFields(double w, double h, TextStyle textstyle) {
    return SizedBox(
      width: w * 1,
      height: h * 0.8,
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w * 0.09, top: h * 0.035),
                  child: Text(
                    "Email",
                    style: textstyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.09, top: 5),
                  child: SizedBox(
                    width: w * 0.8,
                    child: TextFormField(
                      controller: emailEditingController,
                      style: textstyle,
                      decoration: const Dialogg()
                          .textFieldInputDecoration("Email", Icons.email),
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)
                                ? null
                                : "Please Enter Correct Email";
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: w * 0.09, top: h * 0.04),
                  child: Text(
                    "Password",
                    style: textstyle,
                  ),
                ),
                Container(
                  width: w * 0.8,
                  margin:
                      EdgeInsets.only(left: w * 0.09, top: 5, bottom: h * 0.1),
                  child: TextFormField(
                    controller: passwordEditingController,
                    keyboardType: TextInputType.text,
                    obscureText: _passwordVisible,
                    style: textstyle,
                    obscuringCharacter: '*',
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
                        hintStyle: const TextStyle(letterSpacing: 1.3),
                        contentPadding: const EdgeInsets.all(15.0),
                        // Inside box padding
                        border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(15))),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Please enter password at least 8 characters';
                      }
                      return null;
                    },
                  ),
                ),
                buttons("Sign Up"),
                Padding(
                  padding: EdgeInsets.only(top: h * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: textstyle,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => SignIn());
                        },
                        child: Text(
                          "Sign In now",
                          style: TextStyle(
                              color: theme().mC,
                              fontFamily: 'PopM',
                              fontSize: 17,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    var _auth1 = FirebaseAuth.instance;
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      final pass = passwordEditingController.text.toString().trim();
      final email = emailEditingController.text.toString().trim();
      try {
        await _auth1.createUserWithEmailAndPassword(
            email: email, password: pass);
        EMAIL = email;
        Get.to(() => const TermsAndCondition(
              val: true,
            ));
        Get.to(() => VerifyScreen(
              email: email,
              pass: pass,
            ));
      } catch (e) {
        popUp("Can\'t Sign Up", e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buttons(String txt) {
    double w = MediaQuery.of(context).size.width;

    return Center(
      child: TextButton(
        onPressed: () {
          signUp();
        },
        child: Container(
          width: w * 0.5,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: theme().mC,
          ),
          child: Center(
              child: (isLoading == false)
                  ? Text(
                      txt,
                      style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'PopR'),
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )),
        ),
      ),
    );
  }

  void popUp(String txt1, String txt2) {
    // Alert(
    //   context: context,
    //   type:AlertType.error,
    //   title: txt1,
    //   desc:  (txt2=='[firebase_auth/invalid-email] The email address is badly formatted.')?"Email is not correct, try with another email"
    //    :(txt2=='[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.')?"Check your internet connection and try again":"Email is already taken, try with another email",

    //   buttons: [
    //     DialogButton(
    //       child: const Text(
    //         "OK",
    //         style: TextStyle(color: Colors.white, fontSize: 20),
    //       ),
    //       onPressed: () => Navigator.pop(context),
    //       width: 120,
    //     )
    //   ],
    // ).show();
  }
}

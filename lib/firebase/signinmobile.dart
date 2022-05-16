import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:look/constant/dailog.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/firebase/termscondition.dart';

class SignInPhone extends StatefulWidget {
  const SignInPhone({Key? key}) : super(key: key);

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  final formKey = GlobalKey<FormState>();
  final otpKey = GlobalKey<FormState>();
  late ConfirmationResult confirmationResult;
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool phoneSel = false;
  late String countryName;
  late String phoneNumber;
  String code = " (Pakistan) +92";
  String simCode = '+92';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextStyle textStyle =
        const TextStyle(fontFamily: "PopR", fontWeight: FontWeight.bold);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: w * 0.1, bottom: w * 0.3),
                child: Image.asset(
                  'assets/look8.png',
                  scale: 5,
                ),
              ),
              (phoneSel == false)
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: Container(
                        width: w,
                        height: h * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: theme().lightmC,
                        ),
                        child: Column(
                          children: [
                            Text("\nENTER YOUR PHONE NUMBER\n\n",
                                style: textStyle),
                            Row(
                              children: [
                                Text('     $code', style: textStyle),
                                IconButton(
                                  onPressed: () {
                                    fun();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                              ),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: const InputDecoration(
                                    hintText: "Phone Number",
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    border: null,
                                  ),
                                  validator: (val) {
                                    if (val!.isEmpty || val.length < 10) {
                                      return "Please enter correct 10 digits of mobile number";
                                    }
                                  },
                                ),
                              ),
                            ),
                            Text(
                              "\n\n\n\n\nContinue to get Confirmation code to\n "
                              "                         your number\n",
                              style: textStyle,
                            ),
                            buttons('NEXT', 0),
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "Enter code you just received",
                            style: TextStyle(
                                fontFamily: 'PopM',
                                fontSize: w * 0.04,
                                color: Colors.black87),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 18.0,
                            ),
                            child: TextField(
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "code",
                                border: null,
                              ),
                            ),
                          ),
                          //  const Text("Continue to get Confirmation code to your number"),
                          buttons("Verify", 1),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void fun() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          code = "  (" + country.name + ")  +" + country.phoneCode;
          countryName = country.name;
          simCode = "+" + country.phoneCode;
        });
      },
    );
  }

  Widget buttons(String txt, int nav) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 10, left: w * 0.03, right: w * 0.03),
      width: w * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: theme().mC,
      ),
      child: TextButton(
        onPressed: () async {
          if (nav == 0) {
            final replaced =
                _phoneController.text.replaceFirst(RegExp('0'), '');
            phoneNumber = simCode + replaced;
            if (formKey.currentState!.validate()) {
              await auth.verifyPhoneNumber(
                phoneNumber: phoneNumber,
                verificationCompleted: (PhoneAuthCredential credential) async {
                  await auth.signInWithCredential(credential);
                },
                verificationFailed: (FirebaseAuthException e) {
                  if (e.code == 'invalid-phone-number') {
                    final snackBar = SnackBar(
                      margin: const EdgeInsets.all(20),
                      behavior: SnackBarBehavior.floating,
                      content: const Text('invalid phone number!'),
                      backgroundColor: (Colors.redAccent),
                      action: SnackBarAction(
                        label: 'dismiss',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                codeSent: (String verificationId, int? resendToken) async {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            title: const Text("Enter SMS Code"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Form(
                                  key: otpKey,
                                  child: TextFormField(
                                    controller: _otpController,
                                    validator: (val) {
                                      if (val!.isEmpty || val.length < 6) {
                                        return "OTP can\'t be less than 6 characters";
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "Done",
                                  style: TextStyle(color: Colors.red),
                                ),
                                onPressed: () async {
                                  if (otpKey.currentState!.validate()) {
                                    FirebaseAuth auth = FirebaseAuth.instance;

                                    String smsCode = _otpController.text.trim();

                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: verificationId,
                                            smsCode: smsCode);

                                    await auth.signInWithCredential(credential);
                                    Get.to(() => const TermsAndCondition(
                                          val: false,
                                        ));
                                  }
                                },
                              )
                            ],
                          ));
                },
                timeout: const Duration(seconds: 100),
                codeAutoRetrievalTimeout: (String verificationId) {
                  // Auto-resolution timed out...
                },
              );
            }
          } else {
            _verifyOTP();
          }
        },
        child: Text(
          txt,
          style: TextStyle(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'PopR'),
        ),
      ),
    );
  }

  void _verifyOTP() async {
    try {
      await confirmationResult.confirm(_otpController.text);
      PHONE = phoneNumber;
      COUNTRY = countryName;
      Get.to(() => const TermsAndCondition(val: false));
    } catch (e) {
      const Dialogg().popUp(context, "Fail to Send OTP",
          "Unable to Send an OTP, Please try again later", 0);
    }
  }
}

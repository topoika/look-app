import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/constant/theme.dart';
import 'package:look/constant/variables.dart';
import 'package:look/profile/uploadphoto.dart';

class CountryPhone extends StatefulWidget {
  const CountryPhone({Key? key}) : super(key: key);

  @override
  _CountryPhoneState createState() => _CountryPhoneState();
}

class _CountryPhoneState extends State<CountryPhone> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: w * 0.3, bottom: w * 0.25),
                  child: Image.asset(
                    'assets/look8.png',
                    scale: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: w * 0.07, right: w * 0.07, bottom: h * 0.04),
                  child: TextFormField(
                    controller: _countryController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              fun();
                            },
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black26,
                            )),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Select Country",
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          wordSpacing: 2.0,
                        ),
                        hintStyle: const TextStyle(letterSpacing: 1.3),
                        contentPadding: const EdgeInsets.all(15.0),

                        // Inside box padding
                        border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(15))),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please select country name";
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: w * 0.07, right: w * 0.07, bottom: h * 0.04),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter phone number",
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          wordSpacing: 2.0,
                        ),
                        hintStyle: const TextStyle(letterSpacing: 1.3),
                        contentPadding: const EdgeInsets.all(15.0),

                        // Inside box padding
                        border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderRadius: BorderRadius.circular(15))),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 11) {
                        return "Please enter correct 11 digits of mobile number";
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: w * 0.3, left: w * 0.03, right: w * 0.03),
                  width: w * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme().mC,
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        COUNTRY = _countryController.text;
                        PHONE = _phoneController.text;
                        Get.to(const UploadPhoto());
                      }
                    },
                    child: Text(
                      "next",
                      style: TextStyle(
                          fontSize: w * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'PopR'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void fun() {}
}

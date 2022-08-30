import 'dart:convert';
import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/utils/custom_containers.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import './utils/button.dart';
import 'package:http/http.dart' as http;

class MobilePhoneLogin extends StatefulWidget {
  const MobilePhoneLogin({Key? key}) : super(key: key);

  @override
  _MobilePhoneLoginState createState() => _MobilePhoneLoginState();
}

class _MobilePhoneLoginState extends StateMVC<MobilePhoneLogin> {
  final UserController _con = UserController();

  _MobilePhoneLoginState() : super(UserController());
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  String country = "Korea";
  String countryCode = "KR";
  String phoneCode = "+82";
  void getCountry() async {
    try {
      var client = http.Client();
      final response = await client.get(Uri.parse("http://ip-api.com/json"));
      if (response.statusCode == 200) {
        log(response.body);
        setState(() {
          countryCode = jsonDecode(response.body)['countryCode'];
          country = jsonDecode(response.body)['country'];
        });
      }
    } catch (e) {
      showSnackBar(context, "Check your internet connection", true);
    }
  }

  @override
  void initState() {
    super.initState();
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: getHorizontal(context) * 0.05,
              ),
              child: Image.asset(
                logo,
                height: getVertical(context) * 0.1,
                width: getHorizontal(context) * 0.25,
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getHorizontal(context) * 0.04),
              child: Container(
                width: getHorizontal(context),
                padding:
                    EdgeInsets.symmetric(vertical: getVertical(context)) * 0.03,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(S.of(context).enter_your_phone_number.toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle1),
                    CountryCodePicker(
                      onInit: (value) {
                        country = value!.name!;
                        phoneCode = value.dialCode.toString();
                      },
                      onChanged: (value) {
                        setState(() {
                          country = value.name!;
                          phoneCode = value.dialCode.toString();
                        });
                      },
                      initialSelection: countryCode,
                      showFlagDialog: true,
                      showDropDownButton: true,
                      flagDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      comparator: (a, b) => b.name!.compareTo(a.name ?? ""),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: getHorizontal(context) * 0.03),
                      margin: EdgeInsets.symmetric(
                          horizontal: getHorizontal(context) * 0.05,
                          vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(.3),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Form(
                        key: _phoneFormKey,
                        child: TextFormField(
                          controller: _phone,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: S.of(context).phone_number,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) => currentUser.value.phone = value,
                          validator: (val) {
                            if (val!.isEmpty || val.length < 9) {
                              return S
                                  .of(context)
                                  .please_enter_a_correct_phone_number;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getHorizontal(context) * 0.1,
                      ),
                      child: Text(
                        S.of(context).continue_to_get_confirmation_code,
                        textAlign: TextAlign.center,
                        textScaleFactor: getTextScale(context),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black.withOpacity(.6),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    buttonWidget(context, () {
                      if (_phoneFormKey.currentState!.validate()) {
                        currentUser.value.country = country;
                        currentUser.value.phone =
                            _phone.text.replaceFirst("0", phoneCode);
                        currentUser.notifyListeners();
                        phoneLogin(currentUser.value.phone!, context);
                      }
                    }, S.of(context).next),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: getHorizontal(context) * 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: divider(1),
                            ),
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.04),
                          ),
                          SizedBox(
                            width: getHorizontal(context) * 0.2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: divider(1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          socialLoginButton(context, () {
                            currentUser.value.country = country;
                            signInWithGoogle(context);
                          }, google, "Google"),
                          socialLoginButton(context, () {
                            currentUser.value.country = country;
                            signInWithFacebook(context);
                          }, fb, "Facebook"),
                          socialLoginButton(
                              context,
                              () => showSnackBar(context, "Coming soon", false),
                              apple,
                              "Apple"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

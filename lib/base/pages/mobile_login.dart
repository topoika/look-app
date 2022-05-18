import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/mobile_verification.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../generated/l10n.dart';
import '../controllers/user_controller.dart';
import './utils/button.dart';

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
  @override
  void initState() {
    setState(() {
      _phone.text = "+82";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: getHorizontal(context) * 0.1,
                    bottom: getHorizontal(context) * 0.3),
                child: Image.asset(
                  logo,
                  scale: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                    top: getVertical(context) * 0.08),
                child: Container(
                  width: getHorizontal(context),
                  height: getVertical(context) * 0.6,
                  padding:
                      EdgeInsets.symmetric(vertical: getVertical(context)) *
                          0.05,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Column(
                    children: [
                      Text(S.of(context).enter_your_phone_number.toUpperCase(),
                          style: Theme.of(context).textTheme.subtitle1),
                      CountryCodePicker(
                        onChanged: (value) {
                          setState(() {
                            _phone.text = value.toString();
                          });
                        },
                        initialSelection: 'KR',
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
                            vertical: 15),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [PhoneInputFormatter()],
                            decoration: InputDecoration(
                              hintText: S.of(context).phone_number,
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) =>
                                currentUser.value.phone = value,
                            validator: (val) {
                              if (val!.isEmpty || val.length < 10) {
                                return S
                                    .of(context)
                                    .please_enter_a_correct_phone_number;
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getHorizontal(context) * 0.1,
                            vertical: 15),
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
                      SizedBox(height: getVertical(context) * 0.06),
                      buttonWidget(context, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MobileVerification()));
                        log("Hello World");
                      }, "Next"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

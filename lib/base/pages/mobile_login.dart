import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
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
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: Container(
                  width: getHorizontal(context),
                  height: getVertical(context) * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Column(
                    children: [
                      Text(S.of(context).enter_your_phone_number,
                          style: Theme.of(context).textTheme.headline3),
                      InkWell(
                        onTap: () => showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            setState(() {
                              _phone.text = "+" + country.countryCode;
                            });
                          },
                        ),
                        child: Row(
                          children: [
                            Text('     +354',
                                textScaleFactor: getTextScale(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
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
                      buttonWidget(context, () {
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

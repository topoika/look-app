import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/user_controller.dart';

class MobilePhoneLogin extends StatefulWidget {
  const MobilePhoneLogin({Key? key}) : super(key: key);

  @override
  _MobilePhoneLoginState createState() => _MobilePhoneLoginState();
}

class _MobilePhoneLoginState extends StateMVC<MobilePhoneLogin> {
  late UserController _con;

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
                  'assets/look8.png',
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
                      Text("\nENTER YOUR PHONE NUMBER\n\n",
                          style: Theme.of(context).textTheme.headline3),
                      Row(
                        children: [
                          Text('     +354',
                              style: Theme.of(context).textTheme.headline3),
                          IconButton(
                            onPressed: () {},
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
                          key: _con.phoneFormKey,
                          child: TextFormField(
                            controller: _phone,
                            keyboardType: TextInputType.number,
                            inputFormatters: [],
                            decoration: const InputDecoration(
                              hintText: "Phone Number",
                              hintStyle: TextStyle(fontWeight: FontWeight.bold),
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
                        style: Theme.of(context).textTheme.headline3,
                      ),
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

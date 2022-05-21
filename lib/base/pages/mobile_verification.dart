import 'dart:async';

import 'package:flutter/material.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../generated/l10n.dart';
import '../Helper/dimension.dart';
import '../controllers/user_controller.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key, required this.verificationId})
      : super(key: key);
  final String verificationId;

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends StateMVC<MobileVerification> {
  final UserController _con = UserController();
  final TextEditingController _sms = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  _MobileVerificationState() : super(UserController());
  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.08),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: getVertical(context) * 0.15,
                  bottom: getVertical(context) * 0.06),
              child: Image.asset(
                logo,
                scale: 5,
              ),
            ),
            SizedBox(height: getVertical(context) * 0.08),
            Text(
              S.of(context).enter_your_code,
              textScaleFactor: getTextScale(context),
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: getVertical(context) * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android_rounded,
                  color: Colors.black,
                  size: getVertical(context) * 0.04,
                ),
                const SizedBox(width: 10),
                Text(
                  currentUser.value.phone ?? S.of(context).phone_number,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(height: getVertical(context) * 0.02),
            Container(
              width: getVertical(context) * 0.8,
              margin: EdgeInsets.only(top: getHorizontal(context) * 0.04),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v!.length < 3) {
                    return "I'm from validator";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: _sms,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onChanged: (String value) {},
              ),
            ),
            SizedBox(height: getVertical(context) * 0.07),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).i_did_not_get_the_code,
                  style: TextStyle(
                    fontSize: getVertical(context) * 0.02,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                    onTap: () {},
                    child: Text(
                      "  " + S.of(context).resend,
                      style: TextStyle(
                          color: Theme.of(context).buttonColor,
                          fontWeight: FontWeight.w700),
                    )),
              ],
            ),
            SizedBox(height: getVertical(context) * 0.12),
            buttonWidget(context, () {
              setState(() {
                currentUser.value.points = 15;
              });
              verifyPhone(widget.verificationId, _sms.text, context);
            }, S.of(context).continue_text)
          ],
        ),
      ),
    );
  }
}

class OtpCharWidget extends StatelessWidget {
  const OtpCharWidget({
    Key? key,
    required TextEditingController first,
  })  : _first = first,
        super(key: key);

  final TextEditingController _first;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 60,
      width: 60,
      child: TextFormField(
        obscureText: true,
        controller: _first,
        autofocus: true,
        obscuringCharacter: "*",
        textInputAction: TextInputAction.next,
        onChanged: (val) {
          if (val != "") {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 30,
          color: Colors.black,
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration:
            const InputDecoration(border: InputBorder.none, counterText: ''),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

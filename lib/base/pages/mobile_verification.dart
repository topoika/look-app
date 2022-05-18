import 'package:flutter/material.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/firebase/termscondition.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../Helper/dimension.dart';
import '../controllers/user_controller.dart';

class MobileVerification extends StatefulWidget {
  const MobileVerification({Key? key}) : super(key: key);

  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends StateMVC<MobileVerification> {
  final UserController _con = UserController();
  final TextEditingController _first = TextEditingController();
  final TextEditingController _second = TextEditingController();
  final TextEditingController _third = TextEditingController();
  final TextEditingController _forth = TextEditingController();
  _MobileVerificationState() : super(UserController());

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
                'assets/look8.png',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OtpCharWidget(first: _first),
                  OtpCharWidget(first: _second),
                  OtpCharWidget(first: _third),
                  OtpCharWidget(first: _forth),
                ],
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const TermsAndCondition(val: true)));
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

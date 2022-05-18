import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';

import '../base/pages/utils/button.dart';
import '../generated/l10n.dart';

class TermsAndCondition extends StatefulWidget {
  final bool val;

  const TermsAndCondition({Key? key, required this.val}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: w * 0.15, bottom: w * 0.1),
              child: Image.asset(
                'assets/look8.png',
                scale: 5,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  S
                      .of(context)
                      .to_use_look_you_must_read_and_agree_to_the_terms_of_user,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                )),
            InkWell(
              onTap: () {
                popUp(context);
              },
              child: _termsPageItem(
                  S.of(context).terms_of_use, 'assets/terms.PNG'),
            ),
            _termsPageItem(S.of(context).location_based_service_terms,
                'assets/personal.PNG'),
            _termsPageItem(S.of(context).personal_information_handling_methods,
                'assets/location.PNG'),
            Padding(
              padding: EdgeInsets.only(top: h * 0.1, left: w * 0.07),
              child: Row(
                children: [
                  Checkbox(
                    value: checkedValue,
                    onChanged: (value) {
                      setState(() {
                        checkedValue = !checkedValue;
                      });
                    },
                  ),
                  SizedBox(
                    width: getHorizontal(context) * 0.5,
                    child: Text(
                      S
                          .of(context)
                          .i_agree_with_above_personal_handling_information,
                      textScaleFactor: getTextScale(context),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            (!checkedValue)
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    margin: EdgeInsets.symmetric(
                        horizontal: getVertical(context) * 0.02, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      S.of(context).next,
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  )
                : buttonWidget(context, () {}, S.of(context).next)
          ],
        ),
      ),
    );
  }

  void popUp(BuildContext ctx) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Terms and Conditions')),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Expanded(
                child: Text(
                  "These are the terms and Conditions or our app",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
    );
  }

  Widget _termsPageItem(text, image) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 15, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getHorizontal(context) * 0.165,
            ),
            child: Image.asset(
              image,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: getHorizontal(context) * 0.5,
            height: getVertical(context) * 0.06,
            child: Text(
              text,
              style: TextStyle(
                fontSize: getHorizontal(context) * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
            ),
          )
        ],
      ),
    );
  }
}

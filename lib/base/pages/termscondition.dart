import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/liveusers.dart';

import 'profile/uploadphoto.dart';
import 'utils/button.dart';
import '../../generated/l10n.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontal(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: getVertical(context) * 0.15,
                  bottom: getHorizontal(context) * 0.1),
              child: Image.asset(
                logo,
                scale: 5,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  S
                      .of(context)
                      .to_use_look_you_must_read_and_agree_to_the_terms_of_user,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
            InkWell(
              focusColor: Colors.transparent,
              onTap: () {
                popUp(context);
              },
              child: _termsPageItem(S.of(context).terms_of_use, terms),
            ),
            _termsPageItem(
                S.of(context).location_based_service_terms, personal),
            _termsPageItem(
                S.of(context).personal_information_handling_methods, location),
            Padding(
              padding: EdgeInsets.only(
                  top: getVertical(context) * 0.1,
                  left: getHorizontal(context) * 0.05),
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
                    width: getHorizontal(context) * 0.7,
                    child: Text(
                      S
                          .of(context)
                          .i_agree_with_above_personal_handling_information,
                      textScaleFactor: getTextScale(context),
                      style: TextStyle(
                          fontSize: getHorizontal(context) * 0.03,
                          fontWeight: FontWeight.bold),
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
                : buttonWidget(
                    context,
                    () => currentUser.value.dob != null
                        ? !widget.val
                            ? Navigator.pushReplacementNamed(
                                context, "/LiveUsers")
                            : Navigator.pop(context)
                        : Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UploadPhoto())),
                    S.of(context).next)
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
          title: Center(child: Text(S.of(context).terms_and_contitions)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  S.of(context).these_are_the_terms_and_conditions_or_our_app,
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
                child: Text(S.of(context).cancel_text),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: Text(S.of(context).ok_text),
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
              left: getHorizontal(context) * 0.08,
              right: getHorizontal(context) * 0.02,
            ),
            child: Image.asset(
              image,
              height: getVertical(context) * 0.035,
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

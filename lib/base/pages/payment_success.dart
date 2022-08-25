import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/liveusers.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/Helper/theme.dart';

import '../../generated/l10n.dart';

class PaymentSuccess extends StatefulWidget {
  PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  bool done = false;
  @override
  void initState() {
    dalay();
    super.initState();
  }

  dalay() async {
    await Future.delayed(Duration(seconds: 5)).then((value) {
      setState(() => done = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LiveUsers()))
            .then((value) => true),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(getHorizontal(context) * 0.1),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme().mC.withOpacity(.2),
                  ),
                  child: done
                      ? Icon(
                          Icons.check,
                          color: Colors.greenAccent,
                          size: getHorizontal(context) * 0.12,
                        )
                      : CircularProgressIndicator(
                          color: Colors.black38,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    done
                        ? "${S.of(context).payment_successful} \n ${S.of(context).points_credited}"
                        : "${S.of(context).processing_text}....",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: getHorizontal(context) * 0.03),
                  ),
                ),
                !done
                    ? SizedBox()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getHorizontal(context) * 0.2),
                        child: buttonWidget(
                            context,
                            () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LiveUsers())),
                            S.of(context).done_text),
                      )
              ],
            ),
          ),
        ));
  }
}

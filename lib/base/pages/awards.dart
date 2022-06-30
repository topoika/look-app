import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/payement_controller.dart';
import 'package:look/base/controllers/user_controller.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/recharge.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';

class Award extends StatefulWidget {
  const Award({
    Key? key,
  }) : super(key: key);

  @override
  _AwardState createState() => _AwardState();
}

class _AwardState extends StateMVC<Award> {
  late PaymentController _con;
  _AwardState() : super(PaymentController()) {
    _con = controller as PaymentController;
  }
  final User _user = currentUser.value;
  int day = DateTime.now().day;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Text(
              S.of(context).coin_store,
              style: TextStyle(fontSize: getHorizontal(context) * 0.055),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  daimond,
                  height: 30,
                ),
                Column(
                  children: [
                    Text(
                      _user.points.toString(),
                      style: TextStyle(fontSize: getHorizontal(context) * 0.05),
                    ),
                    Text(
                      S.of(context).my_points,
                      style: TextStyle(fontSize: getHorizontal(context) * 0.03),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: getHorizontal(context) * 0.55,
              padding: const EdgeInsets.all(10),
              margin:
                  EdgeInsets.only(top: 10, bottom: getVertical(context) * 0.05),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme().mC,
              ),
              child: Text(
                S.of(context).free_recharge + "\n" + S.of(context).daily_task,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                cont(10),
                cont(20),
                cont(30),
                cont(30),
                cont(50),
                cont(60),
                cont(70),
                cont(80),
                cont(90),
                cont(100),
                cont(110),
                cont(120),
              ],
            ),
            buttonWidget(
                context,
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Recharge())),
                S.of(context).recharge),
          ]),
        ),
      ),
    );
  }

  int selected = 0;
  Widget cont(int number) {
    return Stack(
      children: [
        GestureDetector(
          onTap: selected != 0
              ? () {
                  setState(() {
                    selected = number;
                  });
                  _con.creditUserPoints(number);
                  snack(number,
                      '$number ${S.of(context).points_collected_visit_tomorrow_to_have_more}');
                }
              : () {
                  snack(number,
                      "You have already collected points for today come back tommorow for more");
                },
          child: Container(
            margin: EdgeInsets.all(getHorizontal(context) * 0.01),
            width: getHorizontal(context) * 0.23,
            height: getVertical(context) * 0.15,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(
              award,
              fit: BoxFit.fill,
            ),
          ),
        ),
        selected == number
            ? Container(
                margin: EdgeInsets.all(getHorizontal(context) * 0.01),
                width: getHorizontal(context) * 0.23,
                height: getVertical(context) * 0.15,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.4),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: getHorizontal(context) * 0.045,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  void snack(int p, String message) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: (Colors.blueAccent),
      action: SnackBarAction(
        label: S.of(context).ok_text,
        onPressed: () => Navigator.pop(context),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

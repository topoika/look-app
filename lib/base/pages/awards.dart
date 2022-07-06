import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/controllers/payement_controller.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/recharge.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool doneToday = false;
  int today = 0;
  @override
  void initState() {
    super.initState();
    doneForToday();
  }

  void doneForToday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("rewarded")) {
      setState(() => doneToday = DateTime.now().day ==
          DateTime.parse(preferences.getString("rewarded")!).day);
    } else {
      setState(() => doneToday = false);
    }
  }

  void setDoneForToday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("rewarded", DateTime.now().toString());
    setState(() => doneToday = true);
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
                  height: 25,
                ),
                SizedBox(width: getHorizontal(context) * .01),
                Column(
                  children: [
                    Text(
                      _user.points.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getHorizontal(context) * 0.05),
                    ),
                    Text(
                      S.of(context).my_points,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: getHorizontal(context) * 0.025),
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
                borderRadius: BorderRadius.circular(40),
                color: theme().mC,
              ),
              child: Text(
                S.of(context).free_recharge + "\n" + S.of(context).daily_task,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.white),
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
            SizedBox(height: getVertical(context) * .04),
            buttonWidget(
                context,
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Recharge())),
                S.of(context).recharge),
            SizedBox(height: getVertical(context) * .015),
            buttonWidget(
                context,
                () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Recharge())),
                S.of(context).vip_ubscription_plan),
          ]),
        ),
      ),
    );
  }

  Widget cont(int number) {
    return Stack(
      children: [
        GestureDetector(
          onTap: doneToday
              ? () {
                  snack(
                      number,
                      S
                          .of(context)
                          .you_have_already_collected_points_for_today_come_back_tommorow_for_more);
                }
              : () {
                  setState(() => today = number);
                  _con.creditUserPoints(context, number, "daily reward");
                  setDoneForToday();
                  snack(number,
                      '$number ${S.of(context).points_collected_visit_tomorrow_to_have_more}');
                },
          child: Container(
            margin: EdgeInsets.all(getHorizontal(context) * 0.01),
            width: getHorizontal(context) * 0.2,
            height: getVertical(context) * 0.14,
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
        today == number
            ? Container(
                margin: EdgeInsets.all(getHorizontal(context) * 0.01),
                width: getHorizontal(context) * 0.2,
                height: getVertical(context) * 0.14,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 17),
                    Icon(
                      Icons.check,
                      size: getHorizontal(context) * 0.1,
                      color: Colors.redAccent,
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: Colors.white.withOpacity(.8),
                      child: Text(
                        "💰 ${number.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.redAccent,
                          fontSize: getHorizontal(context) * 0.045,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }

  void snack(int p, String message) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
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

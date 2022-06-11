import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/models/user_model.dart';
import 'package:look/base/pages/utils/button.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/recharge.dart';

import '../../generated/l10n.dart';

class Award extends StatefulWidget {
  const Award({
    Key? key,
  }) : super(key: key);

  @override
  _AwardState createState() => _AwardState();
}

class _AwardState extends State<Award> {
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
              // mainAxisAlignment: MainAxisAlignment.center,
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

  Widget cont(int number) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
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
        Container(
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
      ],
    );
  }

  void snack(int p) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text(
          '$p ${S.of(context).points_collected_visit_tomorrow_to_have_more}'),
      backgroundColor: (Colors.blueAccent),
      action: SnackBarAction(
        label: S.of(context).ok_text,
        onPressed: () => Navigator.pop(context),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

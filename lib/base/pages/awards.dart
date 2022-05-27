import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/models/user_model.dart';
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
                "        Free Recharge\n          Daily Task",
                style: TextStyle(
                    fontFamily: 'PopB',
                    fontSize: getHorizontal(context) * 0.05,
                    color: Colors.black),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    // await FirebaseFirestore.instance
                    //     .collection('Users')
                    //     .doc(widget.uid)
                    //     .update({
                    //   'points': widget.coins + 10,
                    // });
                    // await FirebaseFirestore.instance
                    //     .collection('award')
                    //     .doc(widget.uid)
                    //     .update({
                    //   'awardNumber': 1,
                    //   'time':
                    //       FieldValue.serverTimestamp(),
                    // });
                    // snack(10);
                    // Navigator.of(context).pop();
                  },
                  child: cont(10),
                ),
                InkWell(
                    onTap: () async {
                      // await FirebaseFirestore.instance
                      //     .collection('Users')
                      //     .doc(widget.uid)
                      //     .update({
                      //   'points': widget.coins + 20,
                      // });
                      // await FirebaseFirestore.instance
                      //     .collection('award')
                      //     .doc(widget.uid)
                      //     .update({
                      //   'awardNumber': 2,
                      //   'time':
                      //       FieldValue.serverTimestamp(),
                      // });
                      // snack(20);
                      // Navigator.of(context).pop();
                    },
                    child: cont(20)),
                InkWell(
                    onTap: () async {
                      // await FirebaseFirestore.instance
                      //     .collection('Users')
                      //     .doc(widget.uid)
                      //     .update({
                      //   'points': widget.coins + 30,
                      // });
                      // await FirebaseFirestore.instance
                      //     .collection('award')
                      //     .doc(widget.uid)
                      //     .update({
                      //   'awardNumber': 3,
                      //   'time':
                      //       FieldValue.serverTimestamp(),
                      // });
                      // snack(30);
                      // Navigator.of(context).pop();
                    },
                    child: cont(30)),
              ],
            ),
            InkWell(
              onTap: () async {
                Get.to(() => const Recharge());
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme().mC,
                ),
                child: Text(
                  S.of(context).points_recharge,
                  style: TextStyle(
                      fontFamily: 'PopB',
                      fontSize: getHorizontal(context) * 0.05,
                      color: Colors.black),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget cont(int number) {
    return Column(
      children: [
        Text(
          '$number',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.all(getHorizontal(context) * 0.01),
          width: getHorizontal(context) * 0.179,
          height: getVertical(context) * 0.2,
          child: Image.asset(
            "assets/award.PNG",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget cont2(int number) {
    return Column(
      children: [
        Text(
          '$number',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          color: Colors.black,
          margin: EdgeInsets.all(getHorizontal(context) * 0.01),
          width: getHorizontal(context) * 0.179,
          height: getVertical(context) * 0.2,
          child: Image.asset(
            "assets/award.PNG",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  void snack(int p) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      content: Text('$p points Collected, visit tomorrow to have more'),
      backgroundColor: (Colors.blueAccent),
      action: SnackBarAction(
        label: 'okay',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

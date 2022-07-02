import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/bigevent.dart';
import 'package:look/base/pages/utils/snackbar.dart';

import '../../generated/l10n.dart';
import '../repositories/user_repository.dart';
import 'bankaccountdeposit.dart';

class Recharge extends StatefulWidget {
  const Recharge({Key? key}) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  @override
  void initState() {
    showBanner();
    super.initState();
  }

  showBanner() async {
    await Future.delayed(Duration(seconds: 2)).then((value) => showSnackBar(
        context, "Get 1.5 times point when you pay for bank accounts", true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).points_recharge,
                    style: TextStyle(
                      fontSize: getHorizontal(context) * 0.046,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).my_points,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.04),
                      ),
                      Text(
                        ": ${currentUser.value.points.toString()}",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.04),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(300, 4.9),
                      box(600, 9.1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(1200, 14.1),
                      box(2700, 25.8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(9000, 74.1),
                      box(20000, 150.0),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(25000, 170.1),
                      box(40000, 189.0),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: getVertical(context) * 0.1),
                      padding: const EdgeInsets.all(10),
                      width: getHorizontal(context) * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                          onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BigEvent())),
                          child: Text(
                            S.of(context).big_event,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: getHorizontal(context) * 0.05),
                          )),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget box(int txt, double price) {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  BankAccountDeposit(bigEventPoints: txt, price: price))),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5, top: 20),
            padding: EdgeInsets.symmetric(
                horizontal: getHorizontal(context) * 0.06, vertical: 12),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black26,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                '${txt}P',
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: getHorizontal(context) * 0.051),
              ),
            ),
          ),
          Text(
            '$currency$price',
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: getHorizontal(context) * 0.045),
          ),
        ],
      ),
    );
  }
}

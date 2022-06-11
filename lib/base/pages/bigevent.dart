import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/base/pages/bankaccountdeposit.dart';

import '../../generated/l10n.dart';
import '../Helper/dimension.dart';
import '../Helper/strings.dart';

class BigEvent extends StatefulWidget {
  const BigEvent({Key? key}) : super(key: key);

  @override
  _BigEventState createState() => _BigEventState();
}

class _BigEventState extends State<BigEvent> {
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
                  icon: const Icon(Icons.arrow_back_ios)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).points_recharge,
                    style: TextStyle(
                      fontSize: getHorizontal(context) * 0.065,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).my_points,
                        style: TextStyle(
                            fontSize: getHorizontal(context) * 0.06,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        currentUser.value.points.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.06),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(450, 4.9),
                      box(900, 9.1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(3000, 14.1),
                      box(10000, 12.8),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(15000, 74.1),
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
      onTap: () {
        Get.to(() => BankAccountDeposit(bigEventPoints: txt, price: price));
      },
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

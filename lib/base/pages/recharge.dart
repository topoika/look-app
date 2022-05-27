import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/pages/bigevent.dart';

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
                            fontWeight: FontWeight.bold,
                            fontSize: getHorizontal(context) * 0.06),
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
                      box(300),
                      box(600),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$4.9'),
                      bottomText('\$9.1'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(1200),
                      box(2700),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$14.1'),
                      bottomText('\$25.8'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      box(9000),
                      box(20000),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomText('\$74.1'),
                      bottomText('\$150'),
                    ],
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: getVertical(context) * 0.16),
                      padding: const EdgeInsets.all(10),
                      width: getHorizontal(context) * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                          onTap: () {
                            Get.to(() => BigEvent());
                          },
                          child: Text(
                            "   Big Event   ",
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

  Widget box(int txt) {
    return InkWell(
      onTap: () {
        Get.to(() => BankAccountDeposit(bigEventPoints: txt));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 20),
        width: getHorizontal(context) * 0.24,
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        child: Center(
            child: Text(
          '${txt}P',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: getHorizontal(context) * 0.06),
        )),
      ),
    );
  }

  Widget bottomText(String txt) {
    return Container(
      width: getHorizontal(context) * 0.2,
      child: Text(
        '  $txt',
        style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: getHorizontal(context) * 0.06),
      ),
    );
  }
}

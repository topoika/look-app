import 'package:flutter/material.dart';
import 'package:look/base/Helper/dimension.dart';
import 'package:look/base/Helper/strings.dart';
import 'package:look/base/pages/payment_success.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/bigevent.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/payement_controller.dart';

class BankAccountDeposit extends StatefulWidget {
  final int bigEventPoints;
  final double price;

  const BankAccountDeposit(
      {Key? key, required this.bigEventPoints, required this.price})
      : super(key: key);

  @override
  _BankAccountDepositState createState() => _BankAccountDepositState();
}

class _BankAccountDepositState extends StateMVC<BankAccountDeposit> {
  late PaymentController _con;
  _BankAccountDepositState() : super(PaymentController()) {
    _con = controller as PaymentController;
  }
  TextEditingController _depositorController = TextEditingController();
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
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\n${widget.bigEventPoints}P\n',
                              style: TextStyle(
                                  fontSize: getHorizontal(context) * 0.06),
                            ),
                            Text("$currency ${widget.price.toString()}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: getHorizontal(context) * 0.06)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _con.formKey,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _depositorController,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                hintText: S
                                    .of(context)
                                    .please_enter_the_depositor_name,
                                hintStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              validator: (val) {
                                return val!.length > 5
                                    ? null
                                    : S
                                        .of(context)
                                        .enter_name_of_five_plus_characters;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'Please Enter the depositor name. If you do not deposit the correct amount or if the '
                            'depositor name is different, the point charging may be delayed',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getHorizontal(context) * 0.04),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: getVertical(context) * 0.1, bottom: 20),
                            padding: const EdgeInsets.all(10),
                            width: getHorizontal(context) * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: theme().mC,
                            ),
                            child: InkWell(
                                onTap: () {
                                  if (_con.formKey.currentState!.validate()) {
                                    _con.creditUserPoints(
                                        widget.bigEventPoints);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PaymentSuccess()));
                                  }
                                },
                                child: Text(
                                  S.of(context).confirm_text,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: getHorizontal(context) * 0.05),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: getVertical(context) * 0.05),
                      padding: const EdgeInsets.all(10),
                      width: getHorizontal(context) * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BigEvent())),
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

  Future<void> _makeSocialMediaRequest() async {
    const url = 'https://www.paypal.com/us/signin';
    if (!await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}

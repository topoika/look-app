import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:look/constant/theme.dart';
import 'package:look/base/pages/bigevent.dart';
import 'package:url_launcher/url_launcher.dart';

class BankAccountDeposit extends StatefulWidget {
  final int bigEventPoints;
  const BankAccountDeposit({Key? key, required this.bigEventPoints})
      : super(key: key);

  @override
  _BankAccountDepositState createState() => _BankAccountDepositState();
}

class _BankAccountDepositState extends State<BankAccountDeposit> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _depositorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
                    'Point Recharge',
                    style: TextStyle(fontSize: w * 0.065, fontFamily: 'PopB'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'My Points   \n',
                        style: TextStyle(
                            fontFamily: 'PopZ',
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.06),
                      ),
                      Text(
                        currentUser.value.points.toString(),
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'PopZ',
                            fontWeight: FontWeight.bold,
                            fontSize: w * 0.06),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '\n${widget.bigEventPoints}P\n',
                              style: TextStyle(fontSize: w * 0.06),
                            ),
                            price(widget.bigEventPoints, w),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _depositorController,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                hintText:
                                    "      Please enter the depositor name",
                                hintStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              validator: (val) {
                                return val!.length > 5
                                    ? null
                                    : "Enter name of 5+ characters";
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            '\nPlease Enter the depositor name. If you do not deposit the correct amount or if the '
                            'depositor name is different, the point charging may be delayed',
                            style: TextStyle(
                                fontFamily: 'PopB', fontSize: w * 0.04),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: h * 0.1, bottom: 20),
                            padding: const EdgeInsets.all(10),
                            width: w * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: theme().mC,
                            ),
                            child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    _makeSocialMediaRequest();
                                  }
                                },
                                child: Text(
                                  "   Confirm   ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * 0.05),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: h * 0.05),
                      padding: const EdgeInsets.all(10),
                      width: w * 0.5,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                          onTap: () {
                            Get.to(() => const BigEvent());
                          },
                          child: Text(
                            "   Big Event   ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: w * 0.05),
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

  Widget price(int p, double w) {
    switch (p) {
      case 300:
        return Text(
          '\n (\$4.9)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 450:
        return Text(
          '\n (\$4.9)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 600:
        return Text(
          '\n (\$9.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 900:
        return Text(
          '\n (\$9.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 1200:
        return Text(
          '\n (\$14.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 1800:
        return Text(
          '\n (\$14.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 2700:
        return Text(
          '\n (\$25.8)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 9000:
        return Text(
          '\n (\$74.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 4050:
        return Text(
          '\n (\$25.8)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 20000:
        return Text(
          '\n (\$150)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 13500:
        return Text(
          '\n (\$74.1)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      case 30000:
        return Text(
          '\n (\$150)\n',
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
      default:
        return Text(
          currentUser.value.toString(),
          style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.06),
        );
    }
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

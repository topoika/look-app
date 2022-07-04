import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:look/base/pages/utils/snackbar.dart';
import 'package:look/base/repositories/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../Helper/dimension.dart';
import '../Helper/strings.dart';
import '../controllers/payement_controller.dart';
import 'utils/custom_containers.dart';

class BigEvent extends StatefulWidget {
  const BigEvent({Key? key}) : super(key: key);

  @override
  _BigEventState createState() => _BigEventState();
}

class _BigEventState extends StateMVC<BigEvent> {
  late PaymentController _con;
  _BigEventState() : super(PaymentController()) {
    _con = controller as PaymentController;
  }
  TextEditingController _depositorController = TextEditingController();
  String step = "select";
  int bigEventPoints = 0;
  double price = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bank Account Deposit",
                style: TextStyle(
                  fontSize: getHorizontal(context) * 0.07,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: S.of(context).my_points,
                  style: TextStyle(
                      fontSize: getHorizontal(context) * 0.04,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: "    " + currentUser.value.points.toString() + "P",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: getHorizontal(context) * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              step == "select"
                  ? Column(
                      children: [
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
                  : step == "name"
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: getHorizontal(context) * 0.1,
                              vertical: 20),
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
                                    '\n${bigEventPoints}P\n',
                                    style: TextStyle(
                                        fontSize:
                                            getHorizontal(context) * 0.06),
                                  ),
                                  Text("$currency ${price.toString()}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getHorizontal(context) * 0.06)),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Form(
                                  key: _con.formKey,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: _depositorController,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      hintText: S
                                          .of(context)
                                          .please_enter_the_depositor_name,
                                      hintStyle: TextStyle(
                                          fontSize:
                                              getHorizontal(context) * 0.034,
                                          fontWeight: FontWeight.w700),
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  'Please Enter the depositor name. If you do not deposit the correct amount or if the '
                                  'depositor name is different, the point charging may be delayed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: getHorizontal(context) * 0.04),
                                ),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (_con.formKey.currentState!.validate()) {
                                      _con.creditUserPoints(context,
                                          bigEventPoints, "bank recharge");
                                      setState(() {
                                        step = "done";
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: getVertical(context) * 0.06,
                                        bottom: 20),
                                    padding: const EdgeInsets.all(10),
                                    width: getHorizontal(context) * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.redAccent,
                                    ),
                                    child: Text(
                                      S.of(context).confirm_text,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              getHorizontal(context) * 0.05),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: getHorizontal(context) * 0.1,
                              vertical: 20),
                          padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: getHorizontal(context) * 0.04),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: <Widget>[
                              item(
                                  "Depositor Name", currentUser.value.name!, 1),
                              item("Acount Holder", _depositorController.text,
                                  1),
                              item("Kakao Bank", "333-12-573804", 1),
                              SizedBox(height: getVertical(context) * 0.05),
                              item("Purchase point", bigEventPoints.toString(),
                                  2),
                              item("Payment Amount",
                                  "$currency${price.toString()}", 2),
                              SizedBox(height: getVertical(context) * 0.09),
                              GestureDetector(
                                onTap: () => Clipboard.setData(
                                        ClipboardData(text: "123456789"))
                                    .then((value) => showSnackBar(
                                        context, "Copied to clipboard", false)),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.redAccent,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.file_copy_outlined,
                                          color: Colors.redAccent,
                                          size: getHorizontal(context) * 0.05,
                                        ),
                                      ),
                                      SizedBox(
                                          width: getHorizontal(context) * 0.02),
                                      Text(
                                        "Copying bank account number",
                                        style: TextStyle(
                                          fontSize:
                                              getHorizontal(context) * 0.036,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
              bigEventBtn(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget item(String text, String name, int option) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: option == 1 ? Colors.black54 : Colors.black,
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: option == 1 ? Colors.black54 : Colors.black,
              ),
            ),
          ],
        ),
      );

  Widget box(int txt, double pr) {
    return GestureDetector(
      onTap: () {
        setState(() {
          price = pr;
          bigEventPoints = txt;
          step = "name";
        });
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
            '$currency$pr',
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
